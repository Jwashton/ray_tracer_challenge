class Matrix2 is Equatable[Matrix2]
  let data: Array[F32]

  new create(aa: F32, ab: F32,
             ba: F32, bb: F32) =>
    data = [
      aa; ab
      ba; bb
    ]
  
  fun apply(row: USize, col: USize): F32? =>
    data((row * 2) + col)?


class Matrix3 is Equatable[Matrix3]
  let data: Array[F32]

  new create(aa: F32, ab: F32, ac: F32,
             ba: F32, bb: F32, bc: F32,
             ca: F32, cb: F32, cc: F32) =>
    data = [
      aa; ab; ac
      ba; bb; bc
      ca; cb; cc
    ]
  
  fun apply(row: USize, col: USize): F32? =>
    data((row * 3) + col)?


class Matrix4 is Equatable[Matrix4]
  let data: Array[F32]

  new create(aa: F32, ab: F32, ac: F32, ad: F32,
             ba: F32, bb: F32, bc: F32, bd: F32,
             ca: F32, cb: F32, cc: F32, cd: F32,
             da: F32, db: F32, dc: F32, dd: F32) =>
    data = [
      aa; ab; ac; ad
      ba; bb; bc; bd
      ca; cb; cc; cd
      da; db; dc; dd
    ]
  
  fun apply(row: USize, col: USize): F32? =>
    data((row * 4) + col)?

  fun eq(that: Tuple box): Bool =>
    
    _roughly_eq(this.data, that.x) and
    _roughly_eq(this.y, that.y) and
    _roughly_eq(this.z, that.z) and
    _roughly_eq(this.w, that.w)