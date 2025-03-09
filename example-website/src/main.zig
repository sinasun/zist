const zist = @import("zist-sdk");
const std = @import("std");

// browser loads initPage function
pub export fn initPage() void {
    const body = zist.getDocumentBody();

    const button = zist.createElement("button");
    zist.setTextContent(button, "Click me");

    zist.addEventListener(button, "click", onButtonClick);

    zist.appendChild(body, button);
}

fn onButtonClick() void {
    const body = zist.getDocumentBody();
    const p = zist.createElement("p");
    zist.setTextContent(p, "Button was clicked!");

    zist.appendChild(body, p);
}
