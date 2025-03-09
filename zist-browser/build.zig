const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "zist-browser",
        .root_source_file = b.path("src/main.zig"),
        .target = b.standardTargetOptions(.{}),
        .optimize = b.standardOptimizeOption(.{}),
    });

    // Create the zist-sdk module
    const zist_sdk_module = b.createModule(.{
        .root_source_file = b.path("../zist-sdk/src/main.zig"),
    });

    // Add the module import using the new API
    exe.root_module.addImport("zist-sdk", zist_sdk_module);

    b.installArtifact(exe);
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| run_cmd.addArgs(args);

    const run_step = b.step("run", "Run the browser");
    run_step.dependOn(&run_cmd.step);
}