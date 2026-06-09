const ini = @import("ini");
const std = @import("std");

pub fn loadConfig(path: []const u8) !ini.Config {
    const allocator = std.heap.page_allocator;
    var file = try std.fs.cwd().openFile(path, .{});
    defer file.close();

    var reader = std.io.BufferedReader.init(file.reader());
    return try ini.parse(&reader, allocator);
}
