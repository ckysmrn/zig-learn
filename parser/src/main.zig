

const std = @import("std");
const print = std.debug.print;
const token = @import("token.zig");
const Cursor = token.Cursor;



pub fn main() !void {
    var scnr = Cursor.fromSlice("hello world");
    const gpa = std.heap.pageSize;
    const DebugAllocator = std.heap.DebugAllocator(.{});
    var dbg_allocator: ?DebugAllocator = null;
    const allocator: std.mem.Allocator = if(@import("builtin").mode == .Debug) {
        dbg_allocator = DebugAllocator{
            .backing_allocator = gpa,
        };
        dbg_allocator.allocator();
    } else {
        gpa;
    };
    defer {
        if (dbg_allocator) |*d|{
            const leaked = d.deinit();
            if (leaked) {
                print("Memory leak detected!\n", .{});
            }
        }
    }
    var words = std.ArrayList([]u8).init(allocator);
    defer words.deinit();
    var buffs = std.ArrayList(u8).init(allocator);
    defer buffs.deinit();
    while (scnr.move()) |c| {
        if (c == ' ') {
            if (buffs.items.len > 0) {
                try words.append(try allocator.dupe(u8, buffs.items));
                buffs.clearRetainingCapacity();
            }
        } else {
            buffs.append(c);
        }
    }
    if (buffs.items.len > 0) {
        try words.append(try allocator.dupe(u8, buffs.items));
    }
    for (words.items) |item| {
        std.debug.print("word: {s}\n", .{item});
    }
}
