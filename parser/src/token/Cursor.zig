source: [:0]const u8,
current: usize,

const Self = @This();


pub inline fn fromSlice(source: [:0]const u8) Self {
    return Self {
        .source = source,
        .current = 0,
    };
}


pub fn peek(self: *Self, index: u32) ?u8 {
    const i = index + self.current;
    if (i >= self.source.len) return null;
    return self.source[i];
}


pub fn move(self: *Self) ?u8 {
    if (self.current >= self.source.len) return null;
    const c = self.source[self.current];
    self.current += 1;
    return c;
}

pub fn moveUntil(self: *Self, comptime C: u8) void {
    while(self.current < self.source.len and self.source[self.current] != C) {
        self.current += 1;
    }
    return;
}

pub fn moveWhile(self: *Self, comptime F: fn(u8) bool) void {
    while(self.current < self.source.len and F(self.source[self.current])) {
        self.current += 1;
    }
}
