use "ponytest"

actor Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  new make() =>
    None

  fun tag tests(test: PonyTest) =>
    test(_TestPoint)
    test(_TestVector)
    test(_TestNewPoint)
    test(_TestNewVector)
    test(_TestInspection)
    test(_TestEquality)
    test(_TestAddition)
    test(_TestSubtractingPoints)
    test(_TestSubtractingVector)
    test(_TestSubtractingTwoVectors)
    test(_TestSubtractingTheZeroVector)
    test(_TestNegatingATuple)
    test(_TestScalarMultiplication1)
    test(_TestScalarMultiplication2)
    test(_TestScalarDivision)
    test(_TestMagnitude1)
    test(_TestMagnitude2)
    test(_TestMagnitude3)
    test(_TestMagnitude4)
    test(_TestNormalizing1)
    test(_TestNormalizing2)
    test(_TestNormalizing3)
    test(_TestDotProduct)
    test(_TestCrossProduct)


class iso _TestPoint is UnitTest
  fun name(): String => "A tuple with w=1.0 is a point"
  fun apply(h: TestHelper) =>
    let a = Tuple(4.3, -4.2, 3.1, 1.0)
    h.assert_eq[F32](a.x, 4.3)
    h.assert_eq[F32](a.y, -4.2)
    h.assert_eq[F32](a.z, 3.1)
    h.assert_eq[F32](a.w, 1.0)
    h.assert_true(a.is_point())
    h.assert_false(a.is_vector())


class iso _TestVector is UnitTest
  fun name(): String => "A tuple with w=0 is a vector"
  fun apply(h: TestHelper) =>
    let a = Tuple(4.3, -4.2, 3.1, 0.0)
    h.assert_eq[F32](a.x, 4.3)
    h.assert_eq[F32](a.y, -4.2)
    h.assert_eq[F32](a.z, 3.1)
    h.assert_eq[F32](a.w, 0.0)
    h.assert_false(a.is_point())
    h.assert_true(a.is_vector())


class iso _TestNewPoint is UnitTest
  fun name(): String => "point() creates tuples with w = 1"
  fun apply(h: TestHelper) =>
    let a = Tuple.point(4.3, -4.2, 3.1)
    h.assert_eq[Tuple](a, Tuple(4.3, -4.2, 3.1, 1.0))


class iso _TestNewVector is UnitTest
  fun name(): String => "vector() creates tuples with w = 0"
  fun apply(h: TestHelper) =>
    let a = Tuple.vector(4.3, -4.2, 3.1)
    h.assert_eq[Tuple](a, Tuple(4.3, -4.2, 3.1, 0.0))


class iso _TestInspection is UnitTest
  fun name(): String => "string() returns human-readable string"
  fun apply(h: TestHelper) =>
    let a = Tuple(4.3, -4.2, 3.1, 1.1)
    h.assert_eq[String](a.string(), "(4.3, -4.2, 3.1, 1.1)")


class iso _TestEquality is UnitTest
  fun name(): String => "Two tuples are equatable"
  fun apply(h: TestHelper) =>
    let a = Tuple(0.1 + 0.2, 2.0, -3.0, 4.0)
    let b = Tuple(0.3, 2.0, -3.0, 4.0)
    h.assert_eq[Tuple](a, b)


class iso _TestAddition is UnitTest
  fun name(): String => "Adding two tuples"
  fun apply(h: TestHelper) =>
    let a1 = Tuple(3, -2, 5, 1)
    let a2 = Tuple(-2, 3, 1, 0)
    h.assert_eq[Tuple](a1 + a2, Tuple(1, 1, 6, 1))


class iso _TestSubtractingPoints is UnitTest
  fun name(): String => "Subtracting two points"
  fun apply(h: TestHelper) =>
    let p1 = Tuple.point(3, 2, 1)
    let p2 = Tuple.point(5, 6, 7)
    h.assert_eq[Tuple](p1 - p2, Tuple.vector(-2, -4, -6))


class iso _TestSubtractingVector is UnitTest
  fun name(): String => "Subtracting a vector from a point"
  fun apply(h: TestHelper) =>
    let p = Tuple.point(3, 2, 1)
    let v = Tuple.vector(5, 6, 7)
    h.assert_eq[Tuple](p - v, Tuple.point(-2, -4, -6))


class iso _TestSubtractingTwoVectors is UnitTest
  fun name(): String => "Subtracting two vectors"
  fun apply(h: TestHelper) =>
    let v1 = Tuple.vector(3, 2, 1)
    let v2 = Tuple.vector(5, 6, 7)
    h.assert_eq[Tuple](v1 - v2, Tuple.vector(-2, -4, -6))


class iso _TestSubtractingTheZeroVector is UnitTest
  fun name(): String => "Subtracting a vector from the zero vector"
  fun apply(h: TestHelper) =>
    let zero = Tuple.vector(0, 0, 0)
    let v = Tuple.vector(1, -2, 3)
    h.assert_eq[Tuple](zero - v, Tuple.vector(-1, 2, -3))


class iso _TestNegatingATuple is UnitTest
  fun name(): String => "Negating a Tuple"
  fun apply(h: TestHelper) =>
    let a = Tuple(1, -2, 3, -4)
    h.assert_eq[Tuple](-a, Tuple(-1, 2, -3, 4))


class iso _TestScalarMultiplication1 is UnitTest
  fun name(): String => "Multiplying a tuple by a scalar"
  fun apply(h: TestHelper) =>
    let a = Tuple(1, -2, 3, -4)
    h.assert_eq[Tuple](a * 3.5, Tuple(3.5, -7, 10.5, -14))


class iso _TestScalarMultiplication2 is UnitTest
  fun name(): String => "Multiplying a tuple by a fraction"
  fun apply(h: TestHelper) =>
    let a = Tuple(1, -2, 3, -4)
    h.assert_eq[Tuple](a * 0.5, Tuple(0.5, -1, 1.5, -2))


class iso _TestScalarDivision is UnitTest
  fun name(): String => "Dividing a tuple by a scalar"
  fun apply(h: TestHelper) =>
    let a = Tuple(1, -2, 3, -4)
    h.assert_eq[Tuple](a / 2, Tuple(0.5, -1, 1.5, -2))


class iso _TestMagnitude1 is UnitTest
  fun name(): String => "Computing the magnitude of vector(1, 0, 0)"
  fun apply(h: TestHelper) =>
    let v = Tuple.vector(1, 0, 0)
    h.assert_eq[F32](v.magnitude(), 1)


class iso _TestMagnitude2 is UnitTest
  fun name(): String => "Computing the magnitude of vector(0, 0, 1)"
  fun apply(h: TestHelper) =>
    let v = Tuple.vector(0, 0, 1)
    h.assert_eq[F32](v.magnitude(), 1)


class iso _TestMagnitude3 is UnitTest
  fun name(): String => "Computing the magnitude of vector(1, 2, 3)"
  fun apply(h: TestHelper) =>
    let v = Tuple.vector(1, 2, 3)
    h.assert_eq[F32](v.magnitude(), 3.741657387)


class iso _TestMagnitude4 is UnitTest
  fun name(): String => "Computing the magnitude of vector(-1, -2, -3)"
  fun apply(h: TestHelper) =>
    let v = Tuple.vector(-1, -2, -3)
    h.assert_eq[F32](v.magnitude(), 3.741657387)


class iso _TestNormalizing1 is UnitTest
  fun name(): String => "Normalizing vector(4, 0, 0) gives (1, 0, 0)"
  fun apply(h: TestHelper) =>
    let v = Tuple.vector(4, 0, 0)
    h.assert_eq[Tuple](v.normalize(), Tuple.vector(1, 0, 0))


class iso _TestNormalizing2 is UnitTest
  fun name(): String => "Normalizing vector(1, 2, 3)"
  fun apply(h: TestHelper) =>
    let v = Tuple.vector(1, 2, 3)
                                        //  vector(1 / √14, 2 / √14, 3 / √14)
    h.assert_eq[Tuple](v.normalize(), Tuple.vector(0.26726, 0.53452, 0.80178))


class iso _TestNormalizing3 is (UnitTest & ForgivingFloats)
  fun name(): String => "The magnitude of a normalized vector = 1"
  fun apply(h: TestHelper) =>
    let v = Tuple.vector(1, 2, 3)
    h.assert_true(_roughly_eq(v.normalize().magnitude(), 1))


class iso _TestDotProduct is UnitTest
  fun name(): String => "The dot product of two tuples"
  fun apply(h: TestHelper) =>
    let a = Tuple.vector(1, 2, 3)
    let b = Tuple.vector(2, 3, 4)
    h.assert_eq[F32](a.dot(b), 20)


class iso _TestCrossProduct is UnitTest
  fun name(): String => "The cross product of two vectors"
  fun apply(h: TestHelper) =>
    let a = Tuple.vector(1, 2, 3)
    let b = Tuple.vector(2, 3, 4)
    h.assert_eq[Tuple](a.cross(b), Tuple.vector(-1, 2, -1))
    h.assert_eq[Tuple](b.cross(a), Tuple.vector(1, -2, 1))
