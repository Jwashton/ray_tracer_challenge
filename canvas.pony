class Canvas
  let _pixels: Array[Color]
  let width: USize
  let height: USize

  new create(width': USize, height': USize) =>
    width = width'
    height = height'
    _pixels = Array[Color].init(Color(0, 0, 0), width * height)

  fun ref pixels(): CanvasPixels =>
    CanvasPixels(_pixels)

  fun ref write_pixel(x: USize, y: USize, color: Color) ? =>
    _pixels.update(x * y, color)?

  fun ref apply(x: USize, y: USize): Color ? =>
    _pixels(x * y)?


class CanvasPixels is Iterator[Color]
  let _pixels: Array[Color]
  var _i: USize

  new create(pixels: Array[Color]) =>
    _pixels = pixels
    _i = 0

  fun has_next(): Bool =>
    _i < _pixels.size()

  fun ref next(): Color ? =>
    _pixels(_i = _i + 1)?

  fun ref rewind(): CanvasPixels =>
    _i = 0
    this
