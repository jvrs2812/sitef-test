const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const os_tag = target.result.os.tag;
    const cpu_arch = target.result.cpu.arch;

    const lib_name = if (os_tag == .windows)
        if (cpu_arch == .x86) "CliSiTef32I" else "CliSiTef64I"
    else if (os_tag == .linux)
        "clisitef"
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
        .win32_module_definition = if (os_tag == .windows and cpu_arch == .x86) b.path("CliSiTef32I.def") else null,
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/export.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    b.installArtifact(libfizzbuzz);
}
