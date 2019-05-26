use "ponytest"
use ".."

actor MatrixTests is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  new make() =>
    None

  fun tag tests(test: PonyTest) =>
    test(_Test4x4)
    test(_Test2x2)
    test(_Test3x3)
    test(_TestEqualitySame)


class iso _Test4x4 is UnitTest
  fun name(): String => "Constructing and inspecting a 4x4 matrix"
  fun apply(h: TestHelper) =>
    let m = Matrix4( 1,    2,    3,    4,
                     5.5,  6.5,  7.5,  8.5,
                     9,   10,   11,   12,
                    13.5, 14.5, 15.5, 16.5)
    try
      h.assert_eq[F32](m(0, 0)?, 1)
      h.assert_eq[F32](m(0, 3)?, 4)
      h.assert_eq[F32](m(1, 0)?, 5.5)
      h.assert_eq[F32](m(1, 2)?, 7.5)
      h.assert_eq[F32](m(2, 2)?, 11)
      h.assert_eq[F32](m(3, 0)?, 13.5)
      h.assert_eq[F32](m(3, 2)?, 15.5)
    end


class iso _Test2x2 is UnitTest
  fun name(): String => "A 2x2 matrix ought to be representable"
  fun apply(h: TestHelper) =>
    let m = Matrix2(-3,  5,
                     1, -2)
    try
      h.assert_eq[F32](m(0, 0)?, -3)
      h.assert_eq[F32](m(0, 1)?, 5)
      h.assert_eq[F32](m(1, 0)?, 1)
      h.assert_eq[F32](m(1, 1)?, -2)
    end


class iso _Test3x3 is UnitTest
  fun name(): String => "A 3x3 matrix ought to be representable"
  fun apply(h: TestHelper) =>
    let m = Matrix3(-3,  5,  0,
                     1, -2, -7,
                     0,  1,  1)
    try
      h.assert_eq[F32](m(0, 0)?, -3)
      h.assert_eq[F32](m(1, 1)?, -2)
      h.assert_eq[F32](m(2, 2)?, 1)
    end


class iso _TestEqualitySame is UnitTest
  fun name(): String => "Matrix equality with identical matrices"
  fun apply(h: TestHelper) =>
    let a = Matrix4(1, 2, 3, 4,
                    5, 6, 7, 8,
                    9, 8, 7, 6,
                    5, 4, 3, 2)
    let b = Matrix4(1, 2, 3, 4,
                    5, 6, 7, 8,
                    9, 8, 7, 6,
                    5, 4, 3, 2)
    h.assert_true(a == b)
