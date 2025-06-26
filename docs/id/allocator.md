
% Macam-macam Allocator di Zig  
% ChatGPT  
% 2025  

# 📘 Macam-macam Allocator di Zig

Zig adalah bahasa yang memberi kontrol penuh terhadap memori, dan menyediakan berbagai jenis **allocator** untuk kebutuhan berbeda. Berikut adalah macam-macam allocator bawaan di Zig beserta contoh penggunaannya.

---

## 1. GeneralPurposeAllocator

Allocator serbaguna yang cocok untuk sebagian besar kasus penggunaan umum, dengan deteksi memory leak dan validasi use-after-free jika debugging diaktifkan.

```zig
const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const data = try allocator.alloc(u8, 100);
    defer allocator.free(data);
}
```

---

## 2. FixedBufferAllocator

Menggunakan buffer statis. Alokasi cepat tanpa grow, cocok untuk kasus kecil dan deterministik.

```zig
const std = @import("std");

pub fn main() void {
    var buffer: [1024]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    const data = allocator.alloc(u8, 128) catch return;
}
```

---

## 3. ArenaAllocator

Allocator berbasis arena, cocok untuk banyak alokasi kecil yang dibebaskan sekaligus. Efisien tapi tidak bisa free satu-satu.

```zig
const std = @import("std");

pub fn main() void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const data = allocator.alloc(u8, 256) catch return;
}
```

---

## 4. PageAllocator

Allocator paling dasar, langsung memetakan memori dari OS. Cocok untuk alokasi besar atau sekali pakai.

```zig
const std = @import("std");

pub fn main() void {
    const allocator = std.heap.page_allocator;

    const data = allocator.alloc(u8, 4096) catch return;
}
```

---

## 5. ThreadLocalAllocator

Digunakan secara implisit pada thread tertentu, jarang dipakai secara manual. Cocok untuk konteks TLS (thread-local storage).

```zig
// Tidak digunakan langsung, tetapi bisa tersedia via std.heap.c_allocator
// atau konfigurasi TLS pada GeneralPurposeAllocator
```

---

## 6. CAllocator

Allocator berbasis `malloc`/`free` dari C. Cocok untuk interoperabilitas dengan library C.

```zig
const std = @import("std");

pub fn main() void {
    const allocator = std.heap.c_allocator;

    const data = allocator.alloc(u8, 512) catch return;
}
```

---

## Catatan Tambahan

- Zig menggunakan `Allocator` sebagai *interface* memori alokasi yang fleksibel.
- Semua `Allocator` mengikuti bentuk `alloc`, `realloc`, dan `free`.
- Gunakan `defer` untuk memastikan `free` dipanggil dan tidak terjadi memory leak.
- Saat debug build, `GeneralPurposeAllocator` akan mendeteksi memory misuse.

---

## Referensi

- [Zig Documentation - std.heap](https://ziglang.org/documentation/master/std/#A;std:heap)
- [Zig Learn Allocators](https://ziglearn.org/chapter-3/#allocators)
