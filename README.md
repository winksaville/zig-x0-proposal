Proposal:

All members of `TypeId.Int` should have well defined semantics and all operations
perform as expected. This is currently true except for `u0` and `i0`. This proposal
attempts is to make `u0` and `i0` first class members of `TypeId.Int`. Below `u0` and
`i0` are referred to as `x0`.

Discussions about x0:
* [#1530](https://github.com/ziglang/zig/issues/1530)
* [#1538](https://github.com/ziglang/zig/issues/1538)
* [#1549](https://github.com/ziglang/zig/issues/1549)
* [#1553](https://github.com/ziglang/zig/issues/1553)
* [#1554](https://github.com/ziglang/zig/issues/1554)
* [#1561](https://github.com/ziglang/zig/issues/1561)
* [#1563](https://github.com/ziglang/zig/issues/1563)
* [#1568](https://github.com/ziglang/zig/issues/1568)
* [#1593](https://github.com/ziglang/zig/issues/1593)


`x0`: Shall have a value of 0.

`@sizeOf(x0)`: Shall be 0.

Address of `var x0` or `var s: struct { f: x0 }`: Shall be unique, this can be accomplished
by always allocating 1 byte for each `var x0` or `var s: struct { f: x0 }`. It is allowed
to optimize away the allocation if the address of such a variable is known to never be taken.

`x0` in a `struct`: Has an indeterminate `@byteOffsetOf` and `@bitOffsetOf`. But shall be
0 to `@sizeOf(struct)` inclusive for `@bytteOffsetOf` and 0 to `@sizeOf(struct) * 8` inclusive
for `@bitOffsetOf`.

`x0` in a `packed struct`: Shall have the `@byteOffsetOf` and `@bitOffsetOf` of the
following non-zero length field. If there is no following non-zero length field, it shall have
the `@byteOffsetOf` and `@bitOffsetOf` as if there was a `u1` field following.

`x0` in a `extern struct`: Not allowed since an `x0` is not supported n a C struct.
