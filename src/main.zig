
test "lsp" {
    const std = @import("std");
    const print = std.debug.print;
    print("Hello world\n", .{});
    const gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer gpa.deinit();
    const allocator = gpa.allocator();
    const text = try allocator.alloc(u8, "text");
    defer allocator.free(text);
    print("{}\n", .{text});


}

pub fn main() !void {
    @import("std").debug.print("Hello World", .{});
}


