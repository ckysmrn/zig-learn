
test "lsp" {
    const std = @import("std");
    std.debug.print("Hello world", .{});
}

pub fn main() !void {
    @import("std").debug.print("Hello World", .{});
}


