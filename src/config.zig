const std = @import("std");

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

pub fn loadConfig(path: []const u8) !Config {
    const allocator = std.heap.page_allocator;
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

    content = try allocator.realloc(content, size);

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
