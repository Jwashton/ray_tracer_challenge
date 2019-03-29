use "ponytest"
use ".."

actor ColorTests is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  new make() =>
    None

  fun tag tests(test: PonyTest) =>
    test(_TestColor)
    test(_TestAddingColors)
    test(_TestSubtractingColors)
    test(_TestScalarMultiplication)
    test(_TestHadamardProduct)


class iso _TestColor is UnitTest
  fun name(): String => "Colors are (red, green, blue) tuples"
  fun apply(h: TestHelper) =>
    let c = Color(-0.5, 0.4, 1.7)
    h.assert_eq[F32](c.red(), -0.5)
    h.assert_eq[F32](c.green(), 0.4)
    h.assert_eq[F32](c.blue(), 1.7)


class iso _TestAddingColors is UnitTest
  fun name(): String => "Adding colors"
  fun apply(h: TestHelper) =>
    let c1 = Color(0.9, 0.6, 0.75)
    let c2 = Color(0.7, 0.1, 0.25)
    h.assert_eq[Color](c1 + c2, Color(1.6, 0.7, 1.0))


class iso _TestSubtractingColors is UnitTest
  fun name(): String => "Subtracting colors"
  fun apply(h: TestHelper) =>
    let c1 = Color(0.9, 0.6, 0.75)
    let c2 = Color(0.7, 0.1, 0.25)
    h.assert_eq[Color](c1 - c2, Color(0.2, 0.5, 0.5))


class iso _TestScalarMultiplication is UnitTest
  fun name(): String => "Multiplying a color by a scalar"
  fun apply(h: TestHelper) =>
    let c = Color(0.2, 0.3, 0.4)
    h.assert_eq[Color](c * 2, Color(0.4, 0.6, 0.8))


class iso _TestHadamardProduct is UnitTest
  fun name(): String => "Multiplying two colors"
  fun apply(h: TestHelper) =>
    let c1 = Color(1, 0.2, 0.4)
    let c2 = Color(0.9, 1, 0.1)
    h.assert_eq[Color](c1.hadamard(c2), Color(0.9, 0.2, 0.04))
