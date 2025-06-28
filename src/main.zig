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

fn println(comptime fmt: []const u8, args: anytype) void {
    std.debug.print(fmt ++ "\n", args);
}

pub fn main() !void {
    println("Hello world", .{});
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        _ = gpa.deinit();
    }
    const allocator = gpa.allocator();
    const text = try allocator.dupe(u8, "text");
    defer allocator.free(text);
    println("{s}", .{text});
    println("-----", .{});
    var cursor1 = Cursor.new("one");
    println("{c}", .{cursor1.peek(1)});
    while (cursor1.next()) |c| {
        print("{c}", .{c});
    }
    println("", .{});
    println("----", .{});
    var cursor2 = Cursor.new("two");
    while (cursor2.next()) |c| {
        print("{c}", .{c});
    }

    //try test_defer();
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
        if (self.offset >= self.source.len) return null;
        const c = self.source[self.offset];
        self.offset += 1;
        return c;
    }

    pub fn peek(self: *Cursor, i: u32) ?u8 {
        const j = i + self.offset;
        if (j >= self.source.len) return null;
        return self.source[j];
    }
};
