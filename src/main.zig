
test "lsp" {

}

pub fn main() !void {
    const std = @import("std");
    const print = std.debug.print;
    print("Hello world\n", .{});
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer gpa.deinit();
    const allocator = gpa.allocator();
    const text = try allocator.dupe(u8, "text");
    defer allocator.free(text);
    print("{}\n", .{text});

}


