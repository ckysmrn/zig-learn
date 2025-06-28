

const std = @import("std");
const print = std.debug.print;
const token = @import("token");
const Cursor = token.Cursor;



pub fn main() !void {
    var scnr = Cursor.fromSlice("hello");
    while (scnr.move()) |c| {
        print("{c}\n", .{c});
    }
}
