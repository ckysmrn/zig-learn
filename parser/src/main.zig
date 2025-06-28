

const std = @import("std");
const print = std.debug.print;
const Scanner = @import("Scanner.zig");


pub fn main() !void {
    var scnr = Scanner.new("hello");
    while (scnr.next()) |c| {
        print("{c}\n", .{c});
    }
}
