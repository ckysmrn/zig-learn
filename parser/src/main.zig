

const std = @import("std");
const print = std.debug.print;
const token = @import("token.zig");
const Cursor = token.Cursor;
const Allocator = std.mem.Allocator;
const DebugAllocatorConfig = std.heap.DebugAllocatorConfig;
const DebugAllocator = std.heap.DebugAllocator;

const Config = DebugAllocatorConfig{};
const DbgAllocator = DebugAllocator(Config);

pub fn main() !void {
    var scnr = Cursor.fromSlice("hello world");
    const gpa = std.heap.page_allocator;
    var allocator = gpa;

    var dbg : ?DbgAllocator = null;
    if (@import("builtin").mode == .Debug) {
        dbg = DbgAllocator{
            .backing_allocator = allocator,
        };
        allocator = dbg.?.allocator();
    }
    defer {
        if(dbg) |*d| {
            const leaked = d.deinit();
            if (leaked == .leak)
                std.debug.print("Memory leak detected.\n", .{});
        }
    }

    var words = std.ArrayList([]u8).init(allocator);
    defer {
        for (words.items) |elem| {
            allocator.free(elem);
        }
        words.deinit();
    }
    var buffs = std.ArrayList(u8).init(allocator);
    defer buffs.deinit();
    while (scnr.move()) |c| {
        if (c == ' ') {
            if (buffs.items.len > 0) {
                try words.append(try allocator.dupe(u8, buffs.items));
                buffs.clearRetainingCapacity();
            }
        } else {
            try buffs.append(c);
        }
    }
    if (buffs.items.len > 0) {
        try words.append(try allocator.dupe(u8, buffs.items));
        buffs.clearRetainingCapacity();
    }
    for (words.items) |item| {
        std.debug.print("word: {s}\n", .{item});
    }

}
