

const std = @import("std");
const print = std.debug.print;
const token = @import("token.zig");
const Cursor = token.Cursor;
const Allocator = std.mem.Allocator;
const DebugAllocatorConfig = std.heap.DebugAllocatorConfig;
const DebugAllocator = std.heap.DebugAllocator;

const AllocWrapper = struct {
    debug: ?DebugAllocator(DebugAllocatorConfig),
    allocator: Allocator,

    pub fn init(
        backing: Allocator,
        config: DebugAllocatorConfig
    ) AllocWrapper {
        const Debug = DebugAllocator(@TypeOf(config));
        var dbg: ?Debug = null;
        var allocator: Allocator = backing;

        if (@import("builtin").mode == .Debug) {
            dbg = Debug{ .backing_allocator = backing };
            allocator = dbg.allocator();
        }
        return AllocWrapper {
            .allocator = allocator,
            .debug = dbg,
        };
    }

    pub fn deinit(self: *AllocWrapper) void {
        if (self.debug) |*dbg| {
            const leaked = dbg.deinit();
            if (leaked) {
                std.debug.print("Memory leak detected\n", .{});
            }
        }
        return;
    }
};

pub fn main() !void {
    var scnr = Cursor.fromSlice("hello world");
    const gpa = std.heap.page_allocator;

    const wrapper = AllocWrapper.init(gpa, .{});
    defer wrapper.deinit();
    const allocator = wrapper.allocator;

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
