const std = @import("std");
const zist = @import("zist-sdk");

pub const Element = struct {
    tag: []const u8,
    text: ?[]const u8 = null,
    children: std.ArrayList(*Element),
    listeners: std.StringHashMap(*const anyopaque),

    pub fn init(alloc: std.mem.Allocator, tag: []const u8) Element {
        return .{
            .tag = tag,
            .children = std.ArrayList(*Element).init(alloc),
            .listeners = std.StringHashMap(*const anyopaque).init(alloc),
        };
    }
};

pub var allocator: std.mem.Allocator = undefined;
pub var document_body: *Element = undefined;

export fn zist_getDocumentBody() *zist.Element {
    return @as(*zist.Element, @ptrCast(@alignCast(document_body)));
}

export fn zist_createElement(tag_ptr: [*]const u8, tag_len: usize) *zist.Element {
    const tag = tag_ptr[0..tag_len];
    const elem = allocator.create(Element) catch unreachable;
    elem.* = Element.init(allocator, tag);
    return @as(*zist.Element, @ptrCast(@alignCast(elem)));
}

export fn zist_setTextContent(element: *zist.Element, text_ptr: [*]const u8, text_len: usize) void {
    const text = text_ptr[0..text_len];
    const elem = @as(*Element, @ptrCast(@alignCast(element)));
    elem.text = text;
}

export fn zist_appendChild(parent: *zist.Element, child: *zist.Element) void {
    const p = @as(*Element, @ptrCast(@alignCast(parent)));
    const c = @as(*Element, @ptrCast(@alignCast(child)));
    p.children.append(c) catch unreachable;
}

export fn zist_addEventListener(element: *zist.Element, event_ptr: [*]const u8, event_len: usize, listener: *const anyopaque) void {
    const event = event_ptr[0..event_len];
    const elem = @as(*Element, @ptrCast(@alignCast(element)));
    elem.listeners.put(event, listener) catch unreachable;
}
