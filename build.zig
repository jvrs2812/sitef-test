const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const os_tag = target.result.os.tag;

    const lib_name = if (os_tag == .windows)
        "clisitef"
    else if (os_tag == .linux)
        "libclisitef"
    else
        "clisitef_generic";

    const versionStr = b.option([]const u8, "version", "application version string") orelse "0.0.0";
    const version = std.SemanticVersion.parse(versionStr) catch std.SemanticVersion{
        .major = 0,
        .minor = 0,
        .patch = 0,
    };

    const libfizzbuzz = b.addLibrary(.{
        .name = lib_name,
        .linkage = .dynamic,
        .version = version,
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/export.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    b.installArtifact(libfizzbuzz);
}
