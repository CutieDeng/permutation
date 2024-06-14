const std = @import("std");
const testing = std.testing;

pub fn init(comptime T: type, src: []T) ?void {
    for (src, 0..) |*s, i| {
        s.* = std.math.cast(T, i) orelse return null;  
    } 
}

pub fn next(comptime T: type, src: []T) bool {
    var buffer: ?usize = null; 
    var last: T = src[0]; 
    for (src[1..], 1..) |s, i| {
        if (s > last) { buffer = i - 1; }
        last = s; 
    }
    const b = buffer orelse return false;
    var idx: ?usize = null; 
    const splitt = src[b]; 
    for (src[b+1..], b+1..) |s, bi| {
        if (s > splitt) idx = bi; 
    } 
    std.mem.swap(T, &src[b], &src[idx.?]); 
    std.mem.reverse(T, src[b+1..]); 
    return true; 
}

test {
    var p: [6]i64 = undefined; 
    var counter: usize = 0; 
    init(i64, &p).?; 
    while (true) {
        counter += 1; 
        const n = next(i64, &p); 
        if (!n) break; 
    }
    std.debug.assert( counter == 720 ); 
}

test {
    var p: [6]i64 = undefined; 
    p = .{ 1, 1, 1, 2, 3, 4 }; 
    var counter: usize = 0; 
    while (true) {
        counter += 1; 
        const n = next(i64, &p); 
        if (!n) break; 
    }
    std.debug.assert( counter == 120 ); 
}