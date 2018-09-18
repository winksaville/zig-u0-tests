// See ziglang/zig [#1544](https://github.com/ziglang/zig/issues/1554)
const assert = @import("std").debug.assert;

// zig: ../src/analyze.cpp:499: ZigType* get_pointer_to_type_extra(CodeGen*, ZigType*, bool, bool, PtrLen, uint32_t, uint32_t, uint32_t): Assertion `byte_alignment == 0' failed.
// Aborted (core dumped)
test "u0-packed-struct-fails" {
    const S = packed struct { f0: u0, };
    var s = S { .f0 = 0, };
    assert(s.f0 == 0);
}
