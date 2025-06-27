const std = @import("std");
const print = std.debug.print;


fn call_err() error{Something} !void {
    return error.Something;
}
fn test_defer() error{Something} !void {
    errdefer print("1", .{});
    errdefer print("2", .{});
    try call_err();
    errdefer print("3", .{});
    errdefer print("4", .{});
}
pub fn main() !void {
    print("Hello world\n", .{});
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        _ = gpa.deinit();
    }
    const allocator = gpa.allocator();
    const text = try allocator.dupe(u8, "text");
    defer allocator.free(text);
    print("{s}\n", .{text});
    try test_defer();
}


