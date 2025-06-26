
test "lsp" {

}

pub fn main() !void {
    const std = @import("std");
    const print = std.debug.print;
    print("Hello world\n", .{});
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        const d = gpa.deinit();
        if(d == .leak) std.testing.expect(false) catch @panic("Cannot free gpa.\n");
    }
    const allocator = gpa.allocator();
    const text = try allocator.dupe(u8, "text");
    defer allocator.free(text);
    print("{}\n", .{text});

}


