class Color is (Equatable[Color] & Stringable & ForgivingFloats)
  let tuple: Tuple

  new create(red': F32, green': F32, blue': F32) =>
    tuple = Tuple.vector(red', green', blue')


  new from_vector(vector: Tuple) =>
    tuple = vector


  fun red(): F32 =>
    tuple.x


  fun green(): F32 =>
    tuple.y


  fun blue(): F32 =>
    tuple.z


  fun eq(that: Color box): Bool =>
    tuple == that.tuple


  fun add(that: Color box): Color =>
    Color.from_vector(tuple + that.tuple)


  fun sub(that: Color box): Color =>
    Color.from_vector(tuple - that.tuple)


  fun mul(that: F32): Color =>
    Color.from_vector(tuple * that)


  fun hadamard(that: Color box): Color =>
    Color(red() * that.red(),
          green() * that.green(),
          blue() * that.blue())


  fun string(): String iso^ =>
    ("(" +
      red().string() + ", " +
      green().string() + ", " +
      blue().string() + ")").string()
