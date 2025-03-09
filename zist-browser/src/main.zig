
const std = @import("std");
const dom = @import("dom.zig");


pub fn main() !void {
    // allocate the DOM
    dom.allocator = std.heap.page_allocator;
    dom.document_body = try dom.allocator.create(dom.Element);
    dom.document_body.* = dom.Element.init(dom.allocator, "body");

    // load the example website
    std.debug.print("Loading example website...\n", .{});
    const lib_path = "../example-website/zig-out/lib/libexample-website.so";

    // use dynamic library loading
    var lib = try std.DynLib.open(lib_path);
    defer lib.close();

    // run the initPage function
    std.debug.print("Initializing page...\n", .{});
    const initPage = lib.lookup(*const fn() void, "initPage") orelse return error.SymbolNotFound;
    initPage();
}
