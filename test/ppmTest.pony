use "ponytest"
use "promises"
use ".."

actor PPMTests is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  new make() =>
    None

  fun tag tests(test: PonyTest) =>
    test(_TestHeader)
    test(_TestBody)


class iso _TestHeader is UnitTest
  fun name(): String => "Constructing the PPM header"
  fun apply(h: TestHelper) =>
    let c = Canvas(5, 3)

    let promise = Promise[String]
    promise.next[None](recover this~_fulfill(h) end)

    let stream = _TestStream(h, promise)

    PPM.from_canvas(c, stream)

    stream.header()
    h.long_test(2_000_000_000) // 2 second timeout

  fun tag _fulfill(h: TestHelper, value: String) =>
    h.assert_eq[String](value, expected())
    h.complete(true)

  fun tag expected(): String =>
    """
    P3
    5 3
    255
    """


class iso _TestBody is UnitTest
  fun name(): String => "Constructing the PPM pixel data"
  fun apply(h: TestHelper) ? =>
    let c = Canvas(5, 3)

    c.write_pixel(0, 0, Color(1.5, 0, 0))?
    c.write_pixel(2, 1, Color(0, 0.5, 0))?
    c.write_pixel(4, 2, Color(-0.5, 0, 1))?

    let promise = Promise[String]
    promise.next[None](recover this~_fulfill(h) end)

    let stream = _TestStream(h, promise)

    PPM.from_canvas(c, stream)

    stream.body()
    h.long_test(2_000_000_000) // 2 second timeout

  fun tag _fulfill(h: TestHelper, value: String) =>
    h.assert_eq[String](value, expected())
    h.complete(true)

  fun tag expected(): String =>
    """
    255 0 0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 128 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 255
    """


actor _TestStream is OutStream
  let _header: String ref = String
  let _body: String ref = String
  let _h: TestHelper
  let _promise: Promise[String]
  var _i: U32 = 0

  new create(h: TestHelper, promise: Promise[String]) =>
    _h = h
    _promise = promise

  be print(data: ByteSeq) =>
    if (_i < 3) then
      _header.append(data)
      _header.append("\n")
    else
      _body.append(data)
      _body.append("\n")
    end
    _i = _i + 1

  be write(data: ByteSeq) =>
    _collect(data)

  be printv(data: ByteSeqIter) =>
    for bytes in data.values() do
      _collect(bytes)
    end

  be writev(data: ByteSeqIter) =>
    for bytes in data.values() do
      _collect(bytes)
    end

  fun ref _collect(data: ByteSeq) =>
    if (_i < 3) then
      _header.append(data)
    else
      _body.append(data)
    end

  be header() =>
    let s: String = _header.clone()
    _promise(s)

  be body() =>
    let s: String = _body.clone()
    _promise(s)
