pub const Element = opaque {};

extern fn zist_getDocumentBody() *Element;
extern fn zist_createElement(tag_ptr: [*]const u8, tag_len: usize) *Element;
extern fn zist_setTextContent(element: *Element, text_ptr: [*]const u8, text_len: usize) void;
extern fn zist_appendChild(parent: *Element, child: *Element) void;
extern fn zist_addEventListener(element: *Element, event_ptr: [*]const u8, event_len: usize, listener: *const anyopaque) void;

// return the document root element
pub fn getDocumentBody() *Element {
    return zist_getDocumentBody();
}


// creates a element
pub fn createElement(tagName: []const u8) *Element {
    return zist_createElement(tagName.ptr, tagName.len);
}

// set text content of an element
pub fn setTextContent(element: *Element, text: []const u8) void {
    zist_setTextContent(element, text.ptr, text.len);
}

// append child element to parent element
pub fn appendChild(parent: *Element, child: *Element) void {
    zist_appendChild(parent, child);
}

// add an event listener to an element
pub fn addEventListener(element: *Element, event: []const u8, listener: *const anyopaque) void {
    const listener_ptr: *const anyopaque = @ptrCast(listener);
    zist_addEventListener(element, event.ptr, event.len, listener_ptr);
}
