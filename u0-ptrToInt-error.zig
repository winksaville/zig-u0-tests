// See [#1553](https://github.com/ziglang/zig/issues/1553)
const std = @import("std");
const assert = std.debug.assert;

test "u0-memory-address" {
    var one: u1 = 1;
    var zero: u0 = 0;
    var pZero = &zero;
    assert(pZero == &zero);

    // $ zig test u0.zig 
    // u0.zig:14:32: error: pointer to size 0 type has no address
    //     var usize_addr = @ptrToInt(pZero);
    //                                ^
    var usize_addr = @ptrToInt(pZero);
}
