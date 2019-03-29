primitive PPM
  fun from_canvas(canvas: Canvas, out: OutStream) =>
    print_header(out, canvas.width, canvas.height)
    print_body(out, canvas)

  fun print_header(out: OutStream, width: USize, height: USize) =>
    out.print("P3")
    out.print(width.string() + " " + height.string())
    out.print("255")

  fun print_body(out: OutStream, canvas: Canvas) =>
    var y: USize = 0
    var x: USize = 0
    let black: Color = Color(0, 0, 0)
    var pixel: Color = black

    while y < canvas.height do
      while x < canvas.width do
        pixel = try canvas(x, y)? else black end

        out.write(pixel.red().string() + " " +
                  pixel.green().string() + " " +
                  pixel.blue().string())

        x = x + 1
      end
      y = y + 1
    end
