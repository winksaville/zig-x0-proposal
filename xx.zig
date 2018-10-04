const std = @import("std");
const warn = std.debug.warn;
const assert = std.debug.assert;

var g_u1: u1 = 0;
var pg_u1: *volatile u1 = &g_u1;

var g_i1: i1 = 0;
var pg_i1: *volatile i1 = &g_i1;

test "g_u1" {
    assert(g_u1 == 0);
    assert(pg_u1 == &g_u1);
    pg_u1.* = 1;
    assert(g_u1 == 1);

    assert(@sizeOf(@typeOf(g_u1)) == 1);
    assert(@typeOf(g_u1).bit_count == 1);
    assert(@ptrToInt(pg_u1) != @ptrToInt(pg_i1));
}

test "g_i1" {
    assert(g_i1 == 0);
    assert(pg_i1 == &g_i1);
    pg_i1.* = -1;
    assert(g_i1 == -1);

    assert(@sizeOf(@typeOf(g_i1)) == 1);
    assert(@typeOf(g_i1).bit_count == 1);
    assert(@ptrToInt(pg_u1) != @ptrToInt(pg_i1));
}

var g_u0: u0 = 0;
var pg_u0: *volatile u0 = &g_u0;

var g_i0: i0 = 0;
var pg_i0: *volatile i0 = &g_i0;

test "g_u0" {
    assert(g_u0 == 0);
    assert(pg_u0 == &g_u0);
    pg_u0.* = 0;
    assert(g_u0 == 0);

    assert(@typeOf(g_u0).bit_count == 0);
    assert(@sizeOf(@typeOf(g_u0)) == 0);
    //assert(@ptrToInt(pg_u0) != @ptrToInt(pg_i0)); // Currently compile error
}

test "g_i0" {
    assert(g_i0 == 0);
    assert(pg_i0 == &g_i0);
    pg_i0.* = 0;
    assert(g_i0 == 0);

    assert(@typeOf(g_i0).bit_count == 0);
    assert(@sizeOf(@typeOf(g_i0)) == 0);
    //assert(@ptrToInt(pg_u0) != @ptrToInt(pg_i0)); // Currently compile error
}

const StructU1 = struct {
    f1_u1: u1,
};

const StructI1 = struct {
    f1_i1: i1,
};

var g_StructU1 = StructU1 {
    .f1_u1 = 0,
};
var pg_StructU1: *volatile StructU1 = &g_StructU1;

var g_StructI1 = StructI1 {
    .f1_i1 = 0,
};
var pg_StructI1: *volatile StructI1 = &g_StructI1;

test "g_StructU1" {
    assert(@ptrToInt(pg_StructU1) != @ptrToInt(pg_StructI1));

    assert(g_StructU1.f1_u1 == 0);
    assert(pg_StructU1 == &g_StructU1);
    pg_StructU1.*.f1_u1 = 1;
    assert(g_StructU1.f1_u1 == 1);

    assert(@byteOffsetOf(@typeOf(g_StructU1), "f1_u1") == 0);
    assert(@bitOffsetOf(@typeOf(g_StructU1), "f1_u1") == 0);
    assert(@sizeOf(@typeOf(g_StructU1)) == 1);
    assert(@typeOf(g_StructU1.f1_u1).bit_count == 1);
}

test "g_StructI1" {
    assert(@ptrToInt(pg_StructU1) != @ptrToInt(pg_StructI1));

    assert(g_StructI1.f1_i1 == 0);
    assert(pg_StructI1 == &g_StructI1);
    pg_StructI1.*.f1_i1 = -1;
    assert(g_StructI1.f1_i1 == -1);

    assert(@byteOffsetOf(@typeOf(g_StructI1), "f1_i1") == 0);
    assert(@bitOffsetOf(@typeOf(g_StructI1), "f1_i1") == 0);
    assert(@sizeOf(@typeOf(g_StructI1)) == 1);
    assert(@typeOf(g_StructI1.f1_i1).bit_count == 1);
}

const Struct2U1 = struct {
    f1_u1: u1,
    f2_u1: u1,
};

const Struct2I1 = struct {
    f1_i1: i1,
    f2_i1: i1,
};

var g_Struct2U1 = Struct2U1 {
    .f1_u1 = 0,
    .f2_u1 = 0,
};
var pg_Struct2U1: *volatile Struct2U1 = &g_Struct2U1;

var g_Struct2I1 = Struct2I1 {
    .f1_i1 = 0,
    .f2_i1 = 0,
};
var pg_Struct2I1: *volatile Struct2I1 = &g_Struct2I1;

test "g_Struct2U1" {
    assert(g_Struct2U1.f1_u1 == 0);
    assert(g_Struct2U1.f2_u1 == 0);
    assert(pg_Struct2U1 == &g_Struct2U1);
    pg_Struct2U1.*.f1_u1 = 1;
    pg_Struct2U1.*.f2_u1 = 1;
    assert(g_Struct2U1.f1_u1 == 1);
    assert(g_Struct2U1.f2_u1 == 1);

    assert(@sizeOf(@typeOf(g_Struct2U1)) > 0);
    assert(@typeOf(g_Struct2U1.f1_u1).bit_count == 1);
    assert(@typeOf(g_Struct2U1.f2_u1).bit_count == 1);

    assert(@ptrToInt(pg_Struct2U1) != @ptrToInt(pg_Struct2I1));

    // byteOffsetOf is indeterminate for plain structs
    assert(@bitOffsetOf(@typeOf(g_Struct2U1), "f1_u1") !=
                @bitOffsetOf(@typeOf(g_Struct2U1), "f2_u1"));
}

test "g_Struct2I1" {
    assert(g_Struct2I1.f1_i1 == 0);
    assert(g_Struct2I1.f2_i1 == 0);
    assert(pg_Struct2I1 == &g_Struct2I1);
    pg_Struct2I1.*.f1_i1 = -1;
    pg_Struct2I1.*.f2_i1 = -1;
    assert(g_Struct2I1.f1_i1 == -1);
    assert(g_Struct2I1.f2_i1 == -1);

    assert(@sizeOf(@typeOf(g_Struct2I1)) > 0);
    assert(@typeOf(g_Struct2I1.f1_i1).bit_count == 1);
    assert(@typeOf(g_Struct2I1.f2_i1).bit_count == 1);

    assert(@ptrToInt(pg_Struct2U1) != @ptrToInt(pg_Struct2I1));

    // byteOffsetOf is indeterminate for plain structs
    assert(@bitOffsetOf(@typeOf(g_Struct2I1), "f1_i1") !=
                @bitOffsetOf(@typeOf(g_Struct2I1), "f2_i1"));
}

const PackedStruct2U1 = packed struct {
    f1_u1: u1,
    f2_u1: u1,
};

const PackedStruct2I1 = packed struct {
    f1_i1: i1,
    f2_i1: i1,
};

var g_PackedStruct2U1 = PackedStruct2U1 {
    .f1_u1 = 0,
    .f2_u1 = 0,
};
var pg_PackedStruct2U1: *volatile PackedStruct2U1 = &g_PackedStruct2U1;

var g_PackedStruct2I1 = PackedStruct2I1 {
    .f1_i1 = 0,
    .f2_i1 = 0,
};
var pg_PackedStruct2I1: *volatile PackedStruct2I1 = &g_PackedStruct2I1;

test "g_PackedStruct2U1" {
    assert(g_PackedStruct2U1.f1_u1 == 0);
    assert(g_PackedStruct2U1.f2_u1 == 0);
    assert(pg_PackedStruct2U1 == &g_PackedStruct2U1);
    pg_PackedStruct2U1.*.f1_u1 = 1;
    pg_PackedStruct2U1.*.f2_u1 = 1;
    assert(g_PackedStruct2U1.f1_u1 == 1);
    assert(g_PackedStruct2U1.f2_u1 == 1);

    assert(@sizeOf(@typeOf(g_PackedStruct2U1)) == 1);
    assert(@typeOf(g_PackedStruct2U1.f1_u1).bit_count == 1);
    assert(@typeOf(g_PackedStruct2U1.f2_u1).bit_count == 1);

    assert(@ptrToInt(pg_PackedStruct2U1) != @ptrToInt(pg_PackedStruct2I1));

    assert(@byteOffsetOf(@typeOf(g_PackedStruct2U1), "f1_u1") == 0);
    assert(@byteOffsetOf(@typeOf(g_PackedStruct2U1), "f2_u1") == 0);

    assert(@ptrToInt(&g_PackedStruct2U1.f1_u1) ==
                @ptrToInt(&g_PackedStruct2U1.f2_u1));

    assert(@bitOffsetOf(@typeOf(g_PackedStruct2U1), "f1_u1") == 0);
    assert(@bitOffsetOf(@typeOf(g_PackedStruct2U1), "f2_u1") == 1);
}

test "g_PackedStruct2I1" {
    assert(g_PackedStruct2I1.f1_i1 == 0);
    assert(g_PackedStruct2I1.f2_i1 == 0);
    assert(pg_PackedStruct2I1 == &g_PackedStruct2I1);
    pg_PackedStruct2I1.*.f1_i1 = -1;
    pg_PackedStruct2I1.*.f2_i1 = -1;
    assert(g_PackedStruct2I1.f1_i1 == -1);
    assert(g_PackedStruct2I1.f2_i1 == -1);

    assert(@sizeOf(@typeOf(g_PackedStruct2I1)) == 1);
    assert(@typeOf(g_PackedStruct2I1.f1_i1).bit_count == 1);
    assert(@typeOf(g_PackedStruct2I1.f2_i1).bit_count == 1);

    assert(@ptrToInt(pg_PackedStruct2U1) != @ptrToInt(pg_PackedStruct2I1));

    assert(@byteOffsetOf(@typeOf(g_PackedStruct2I1), "f1_i1") == 0);
    assert(@byteOffsetOf(@typeOf(g_PackedStruct2I1), "f2_i1") == 0);

    assert(@bitOffsetOf(@typeOf(g_PackedStruct2I1), "f1_i1") == 0);
    assert(@bitOffsetOf(@typeOf(g_PackedStruct2I1), "f2_i1") == 1);
}

const PackedStruct4Fields = packed struct {
    f1: u1,
    f2: u64,
    f3: i1,
    f4: u64,
};

var g_PackedStruct4Fields = PackedStruct4Fields {
    .f1 = 0,
    .f2 = 0,
    .f3 = 0,
    .f4 = 0,
};
var pg_PackedStruct4Fields: *volatile PackedStruct4Fields = &g_PackedStruct4Fields;

test "g_PackedStruct4Fields" {
    assert(g_PackedStruct4Fields.f1 == 0);
    assert(g_PackedStruct4Fields.f2 == 0);
    assert(g_PackedStruct4Fields.f3 == 0);
    assert(pg_PackedStruct4Fields == &g_PackedStruct4Fields);
    pg_PackedStruct4Fields.*.f1 = 1;
    pg_PackedStruct4Fields.*.f2 = 1;
    pg_PackedStruct4Fields.*.f3 = -1;
    assert(g_PackedStruct4Fields.f1 == 1);
    assert(g_PackedStruct4Fields.f2 == 1);
    assert(g_PackedStruct4Fields.f3 == -1);

    assert(@sizeOf(@typeOf(g_PackedStruct4Fields)) == 17);
    assert(@typeOf(g_PackedStruct4Fields.f1).bit_count == 1);
    assert(@typeOf(g_PackedStruct4Fields.f2).bit_count == 64);
    assert(@typeOf(g_PackedStruct4Fields.f3).bit_count == 1);
    assert(@typeOf(g_PackedStruct4Fields.f4).bit_count == 64);

    assert(@byteOffsetOf(@typeOf(g_PackedStruct4Fields), "f1") == 0);
    assert(@byteOffsetOf(@typeOf(g_PackedStruct4Fields), "f2") == 0);
    assert(@byteOffsetOf(@typeOf(g_PackedStruct4Fields), "f3") == 0);
    assert(@byteOffsetOf(@typeOf(g_PackedStruct4Fields), "f4") == 0);

    assert(@ptrToInt(&g_PackedStruct4Fields.f1) ==
                @ptrToInt(&g_PackedStruct4Fields.f2));
    assert(@ptrToInt(&g_PackedStruct4Fields.f2) ==
                @ptrToInt(&g_PackedStruct4Fields.f3));
    assert(@ptrToInt(&g_PackedStruct4Fields.f3) ==
                @ptrToInt(&g_PackedStruct4Fields.f4));

    assert(@bitOffsetOf(@typeOf(g_PackedStruct4Fields), "f1") == 0);
    assert(@bitOffsetOf(@typeOf(g_PackedStruct4Fields), "f2") == 1);
    assert(@bitOffsetOf(@typeOf(g_PackedStruct4Fields), "f3") == 65);
    assert(@bitOffsetOf(@typeOf(g_PackedStruct4Fields), "f4") == 66);
}
