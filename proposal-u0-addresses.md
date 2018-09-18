Currently I can take the address of a u0 and it behaves as I'd expect most of the time, so my assumption was that those places where I can't take the address are bugs.

In anycase my feeling is that u0's should behave like u1..uN. You can see that in [zig-u0-tests](https://github.com/winksaville/zig-u0-tests/blob/master/u0.zig) that I posted yesterday on IRC. I created this issue as it represents a simple case a place I couldn't take the address. As you can see in zig-u0-tests the status quo very close to the what I'd like.

I'd suggest another way to look at a u0 is that it actually represents an address and since its @sizeOf(u0) == 0, and has only a single predefined value of 0, reads and writes are optimized away.

Anyway, this morning I've come up with use case for a u0 address. It can be used as a "label" in a struct. These labels can be useful for identifying sections in a struct without the necessity of nesting additional structs. Thus keeping access and describing the structure simpler.

Also, since a u0 has only a single known value it should not be required to explicitly initialize them in structure literals. In the example below .top, .middle and .bottom would not have to be initialized and even could be removed from the literal. This is a further simplification over using nested structs.

Of course this "only" works with "packed struct" which appears to have a bug, #1554, when handling u0's, so the code below doesn't yet compile.

I also propose that u0's would act like "fences" and the compiler would not be allowed to move fields across u0 boundaries, this gives the compiler more freedom then "packed" but less than "unpacked".

Further more I think it would be worth while to allow alignment and explicit setting of the offsets to u0's to make it easier to overlay a struct on top of hardware.
```
const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

const U0 = packed struct { 
    top: u0,
    f1: u32,
    f2: u64,
    
    middle: u0,
    f3: u1,
    f4: u1,
    
    bottom: u0,
    f5: u128,
};

test "U0" {
    //warn("\n");

    var sU0 = U0 {
        .top = 0,
        .f1 = 1,
        .f2 = 2,

        .middle = 0,
        .f3 = 1,
        .f4 = 0,

        .bottom = 0,
        .f5 = 0x123456789,
    };

    assert(sU0.top == 0);
    assert(sU0.f1 == 1);
    assert(sU0.f2 == 2);
    assert(sU0.middle == 0);
}
```
