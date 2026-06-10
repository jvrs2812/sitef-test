const std = @import("std");
const builtin = @import("builtin");

pub const Config = struct {
    allocator: std.mem.Allocator,
    content: []u8,
    values: std.StringHashMap([]const u8),

    pub fn deinit(self: *Config) void {
        var iterator = self.values.keyIterator();
        while (iterator.next()) |key| {
            self.allocator.free(key.*);
        }
        self.values.deinit();
        self.allocator.free(self.content);
    }

    pub fn getString(self: *const Config, section: []const u8, key: []const u8) ?[]const u8 {
        const full_key = std.fmt.allocPrint(self.allocator, "{s}.{s}", .{ section, key }) catch return null;
        defer self.allocator.free(full_key);
        return self.values.get(full_key);
    }

    pub fn getInt(self: *const Config, section: []const u8, key: []const u8) ?i32 {
        const value = self.getString(section, key) orelse return null;
        return std.fmt.parseInt(i32, std.mem.trim(u8, value, " \t\r\n"), 10) catch null;
    }
};

fn readFileAlloc(allocator: std.mem.Allocator, path: []const u8) ![]u8 {
    return switch (builtin.os.tag) {
        .windows => readFileAllocWindows(allocator, path),
        else => readFileAllocPosix(allocator, path),
    };
}

fn readFileAllocPosix(allocator: std.mem.Allocator, path: []const u8) ![]u8 {
    const fd = try std.posix.openat(std.posix.AT.FDCWD, path, .{}, 0);
    defer std.Io.Threaded.closeFd(fd);

    var capacity: usize = 4096;
    var content = try allocator.alloc(u8, capacity);
    errdefer allocator.free(content);

    var size: usize = 0;
    while (true) {
        if (size == capacity) {
            capacity *= 2;
            if (capacity > 1024 * 1024) return error.FileTooBig;
            content = try allocator.realloc(content, capacity);
        }

        const bytes_read = try std.posix.read(fd, content[size..capacity]);
        if (bytes_read == 0) break;
        size += bytes_read;
    }

    return try allocator.realloc(content, size);
}

fn readFileAllocWindows(allocator: std.mem.Allocator, path: []const u8) ![]u8 {
    const windows = std.os.windows;
    const DWORD = windows.DWORD;
    const BOOL = windows.BOOL;
    const HANDLE = windows.HANDLE;

    const GENERIC_READ: DWORD = 0x80000000;
    const FILE_SHARE_READ: DWORD = 0x00000001;
    const OPEN_EXISTING: DWORD = 3;
    const FILE_ATTRIBUTE_NORMAL: DWORD = 0x00000080;
    const INVALID_FILE_SIZE: DWORD = 0xffffffff;

    const kernel32 = struct {
        extern "kernel32" fn CreateFileA(
            lpFileName: [*:0]const u8,
            dwDesiredAccess: DWORD,
            dwShareMode: DWORD,
            lpSecurityAttributes: ?*anyopaque,
            dwCreationDisposition: DWORD,
            dwFlagsAndAttributes: DWORD,
            hTemplateFile: ?HANDLE,
        ) callconv(.winapi) HANDLE;

        extern "kernel32" fn GetFileSize(
            hFile: HANDLE,
            lpFileSizeHigh: ?*DWORD,
        ) callconv(.winapi) DWORD;

        extern "kernel32" fn ReadFile(
            hFile: HANDLE,
            lpBuffer: [*]u8,
            nNumberOfBytesToRead: DWORD,
            lpNumberOfBytesRead: *DWORD,
            lpOverlapped: ?*anyopaque,
        ) callconv(.winapi) BOOL;

        extern "kernel32" fn CloseHandle(hObject: HANDLE) callconv(.winapi) BOOL;
    };

    const path_z = try allocator.dupeZ(u8, path);
    defer allocator.free(path_z);

    const file = kernel32.CreateFileA(
        path_z.ptr,
        GENERIC_READ,
        FILE_SHARE_READ,
        null,
        OPEN_EXISTING,
        FILE_ATTRIBUTE_NORMAL,
        null,
    );
    if (file == windows.INVALID_HANDLE_VALUE) return error.FileNotFound;
    defer _ = kernel32.CloseHandle(file);

    var file_size_high: DWORD = 0;
    const file_size_low = kernel32.GetFileSize(file, &file_size_high);
    if (file_size_low == INVALID_FILE_SIZE or file_size_high != 0) return error.FileTooBig;
    if (file_size_low > 1024 * 1024) return error.FileTooBig;

    const content = try allocator.alloc(u8, @intCast(file_size_low));
    errdefer allocator.free(content);

    var bytes_read: DWORD = 0;
    if (!kernel32.ReadFile(file, content.ptr, file_size_low, &bytes_read, null).toBool()) {
        return error.ReadFailed;
    }

    return try allocator.realloc(content, @intCast(bytes_read));
}

pub fn loadConfig(path: []const u8) !Config {
    const allocator = std.heap.page_allocator;
    const content = try readFileAlloc(allocator, path);
    errdefer allocator.free(content);

    var result = Config{
        .allocator = allocator,
        .content = content,
        .values = std.StringHashMap([]const u8).init(allocator),
    };
    errdefer result.deinit();

    var current_section: []const u8 = "";
    var lines = std.mem.splitScalar(u8, content, '\n');
    while (lines.next()) |raw_line| {
        const line = std.mem.trim(u8, raw_line, " \t\r\n");
        if (line.len == 0 or line[0] == '#') continue;

        if (line[0] == '[' and line[line.len - 1] == ']') {
            current_section = std.mem.trim(u8, line[1 .. line.len - 1], " \t\r\n");
            continue;
        }

        const separator_index = std.mem.indexOfScalar(u8, line, '=') orelse continue;
        const key = std.mem.trim(u8, line[0..separator_index], " \t\r\n");
        const value = std.mem.trim(u8, line[separator_index + 1 ..], " \t\r\n");
        const full_key = try std.fmt.allocPrint(allocator, "{s}.{s}", .{ current_section, key });
        try result.values.put(full_key, value);
    }

    return result;
}
