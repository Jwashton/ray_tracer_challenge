use "ponytest"
use ".."

actor CanvasTests is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  new make() =>
    None

  fun tag tests(test: PonyTest) =>
    test(_TestCanvas)
    test(_TestWriting)


class iso _TestCanvas is UnitTest
  fun name(): String => "Creating a canvas"
  fun apply(h: TestHelper) =>
    let c = Canvas(10, 20)
    h.assert_eq[USize](c.width, 10)
    h.assert_eq[USize](c.height, 20)

    let black = Color(0, 0, 0)

    for pixel in c.pixels() do
      h.assert_eq[Color](pixel, black)
    end


class iso _TestWriting is UnitTest
  fun name(): String => "Writing pixels to a canvas"
  fun apply(h: TestHelper) =>
    let c = Canvas(10, 20)
    let red = Color(1, 0, 0)

    try
      c.write_pixel(2, 3, red)?

      h.assert_eq[Color](c(2, 3)?, red)
    end
