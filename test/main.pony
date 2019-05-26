use "ponytest"

actor Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  new make() =>
    None

  fun tag tests(test: PonyTest) =>
    TupleTests.make().tests(test)
    ColorTests.make().tests(test)
    CanvasTests.make().tests(test)
    PPMTests.make().tests(test)
    MatrixTests.make().tests(test)
