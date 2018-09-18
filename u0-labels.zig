// Using u0 as a label allows user to identify areas within
// a structure and is useful for separting areas within a
// struct without nesting of structures and thus keeping the
// structure simpler.
//
// Another possible property is that u0 shouldn't require
// initialization as there is only one possible value.

const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

//const U0 = packed struct { // crashes compiler #
const U0 = struct {
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

    // Add more tests once packed structs work with u0's
}
