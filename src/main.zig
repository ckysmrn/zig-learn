const std = @import("std");
const print = std.debug.print;


fn call_err() error{Something} !void {
    return error.Something;
}
fn test_defer() error{Something} !void {
    defer print("1", .{});
    defer print("2", .{});
    try call_err();
    defer print("3", .{});
    defer print("4", .{});
    return;
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
    const cursor1 = Cursor.new("one");
    if (cursor1.next()) |c| {
        print("{}", .{c});
    }
    try test_defer();
}


const Cursor = struct {
    source: []const u8,
    offset: u32,

    pub fn new(input: []const u8) Cursor {

        return Cursor{
            .source = input,
            .offset = 0,
        };
    }

    pub fn next(self: *Cursor) ?u8 {
        const c = self.source[self.offset];
        self.offset += 1;
        return c;
    }
};
