trait ForgivingFloats
  fun _epsilon(): F32 => 0.00001

  fun _roughly_eq(a: F32, b: F32): Bool =>
    (a - b).abs() < _epsilon()
  

class Tuple is (Equatable[Tuple] & Stringable & ForgivingFloats)
  let x: F32
  let y: F32
  let z: F32
  let w: F32

  new create(x': F32, y': F32, z': F32, w': F32) =>
    x = x'
    y = y'
    z = z'
    w = w'


  new point(x': F32, y': F32, z': F32) =>
    x = x'
    y = y'
    z = z'
    w = 1.0


  new vector(x': F32, y': F32, z': F32) =>
    x = x'
    y = y'
    z = z'
    w = 0.0


  fun is_point(): Bool =>
    w == 1.0


  fun is_vector(): Bool =>
    w == 0.0


  fun eq(that: Tuple box): Bool =>
    _roughly_eq(this.x, that.x) and
    _roughly_eq(this.y, that.y) and
    _roughly_eq(this.z, that.z) and
    _roughly_eq(this.w, that.w)


  fun add(that: Tuple box): Tuple =>
    Tuple(this.x + that.x,
          this.y + that.y,
          this.z + that.z,
          this.w + that.w)


  fun sub(that: Tuple box): Tuple =>
    Tuple(this.x - that.x,
          this.y - that.y,
          this.z - that.z,
          this.w - that.w)


  fun neg(): Tuple =>
    Tuple(-this.x, -this.y, -this.z, -this.w)


  fun mul(that: F32): Tuple =>
    Tuple(this.x * that,
          this.y * that,
          this.z * that,
          this.w * that)


  fun div(that: F32): Tuple =>
    Tuple(this.x / that,
          this.y / that,
          this.z / that,
          this.w / that)


  fun magnitude(): F32 =>
    ((x * x) + (y * y) + (z * z) + (w * w)).sqrt()


  fun normalize(): Tuple =>
    let mag = magnitude()

    Tuple(x / mag, y / mag, z / mag, w / mag)


  fun dot(that: Tuple): F32 =>
    (this.x * that.x) +
    (this.y * that.y) +
    (this.z * that.z) +
    (this.w * that.w)


  fun cross(that: Tuple): Tuple =>
    Tuple.vector((this.y * that.z) - (this.z * that.y),
                 (this.z * that.x) - (this.x * that.z),
                 (this.x * that.y) - (this.y * that.x))


  fun string(): String iso^ =>
    ("(" +
      x.string() + ", " +
      y.string() + ", " +
      z.string() + ", " +
      w.string() + ")").string()
