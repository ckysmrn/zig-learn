// pub const Cursor = @import("token/Cursor.zig");

pub const Cursor = struct{

   source: [:0]const u8,
   current: usize,

   pub inline fn fromSlice(source: [:0]const u8) Cursor {
       return Cursor {
           .source = source,
           .current = 0,
       };
   }


   pub fn peek(self: *Cursor, index: u32) ?u8 {
       const i = index + self.current;
       if (i >= self.source.len) return null;
       return self.source[i];
   }


   pub fn move(self: *Cursor) ?u8 {
       if (self.current >= self.source.len) return null;
       const c = self.source[self.current];
       self.current += 1;
       return c;
   }

   pub fn moveUntil(self: *Cursor, comptime C: u8) void {
       while(self.current < self.source.len and self.source[self.current] != C) {
           self.current += 1;
       }
       return;
   }

   pub fn moveWhile(self: *Cursor, comptime F: fn(u8) bool) void {
       while(self.current < self.source.len and F(self.source[self.current])) {
           self.current += 1;
       }
   }

};
