


source: []const u8,
offset: u32,

const Self = @This();

pub fn new(data: []const u8) Self {
    return Self{
        .offset = 0, .source = data
    };
}


pub fn next(self: *Self) ?u8 {
    if (self.offset >= self.source.len) return null;
    const c = self.source[self.offset];
    self.offset += 1;
    return c;
}


