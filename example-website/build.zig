const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});


    // create a shared library
    const lib = b.addSharedLibrary(.{
        .name = "example-website",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    const zist_sdk_module = b.createModule(.{
        .root_source_file = b.path("../zist-sdk/src/main.zig"),
    });
    lib.root_module.addImport("zist-sdk", zist_sdk_module);

    // outputs to zig-out/lib/
    b.installArtifact(lib);
}
