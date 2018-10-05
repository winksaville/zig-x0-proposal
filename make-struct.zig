const std = @import("std");
const warn = std.debug.warn;
const assert = std.debug.assert;

fn MakeStruct(comptime TypeF1: type, comptime TypeF2: type, comptime pack: bool) type {
    if (pack) {
        return packed struct {
            f1: TypeF1,
            f2: TypeF2,
        };
    } else {
        return struct {
            f1: TypeF1,
            f2: TypeF2,
        };
    }
}

fn testMakeStruct(comptime pack: bool) void {
    warn("\n");
    const Struct = MakeStruct(u1, u8, pack);
    var s = Struct {
        .f1 = 0,
        .f2 = 0,
    };
    assert(s.f1 == 0);
    assert(s.f2 == 0);
    assert((@ptrToInt(&s) == @ptrToInt(&s.f1)) or (@ptrToInt(&s) == @ptrToInt(&s.f2)));
    warn("{s30} : {}\n", "s", s);
    warn("{s30} : {*}\n", "&s", &s);
    warn("{s30} : {*}\n", "&s.f1", &s.f1);
    warn("{s30} : {*}\n", "&s.f2", &s.f2);
    warn("{s30} : {} {}\n", "@byteOffsetOf f1 f2",
        @intCast(usize, @byteOffsetOf(Struct, "f1")),
        @intCast(usize, @byteOffsetOf(Struct, "f2")));
    warn("{s30} : {} {}\n", "@bitOffsetOf f1 f2",
        @intCast(usize, @bitOffsetOf(Struct, "f1")),
        @intCast(usize, @bitOffsetOf(Struct, "f2")));
}

test "MakeStruct.u1.u8.not.packed" {
    testMakeStruct(false);
}

test "MakeStruct.u1.u8.packed" {
    testMakeStruct(true);
}
