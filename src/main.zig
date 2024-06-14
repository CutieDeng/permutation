const std = @import("std");
const permutation = @import("permutation"); 

pub fn main() !void {
    var buf: [15] i32 = undefined; 
    permutation.init(i32, &buf).? ;
    std.debug.print("View first 15 selections of buf[15]: \n", .{}); 
    for (0..15) |v| {
        std.debug.print("{}: {any}\n", .{ v, buf }); 
        if (v != 14) {
            _ = permutation.next(i32, &buf); 
        }
    }
}
