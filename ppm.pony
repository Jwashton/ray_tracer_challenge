primitive PPM
  fun from_canvas(canvas: Canvas, out: OutStream)? =>
    print_header(out, canvas.width, canvas.height)
    print_body(out, canvas)?

  fun print_header(out: OutStream, width: USize, height: USize) =>
    out.print("P3")
    out.print(width.string() + " " + height.string())
    out.print("255")

  fun print_body(out: OutStream, canvas: Canvas)? =>
    var y: USize = 0
    var x: USize = 0
    var lineLength: USize = 0
    let black: Color = Color(0, 0, 0)
    var pixel: Color = black

    while y < canvas.height do
      while x < canvas.width do
        pixel = canvas(x, y)?

        let red: String = (pixel.red() * 255).min(255).max(0).round().string()
        let green: String = (pixel.green() * 255).min(255).max(0).round().string()
        let blue: String = (pixel.blue() * 255).min(255).max(0).round().string()

        out.write(red)
        lineLength = lineLength + red.size()

        if lineLength < 67 then
          out.write(" " + green)
          lineLength = lineLength + green.size() + 1

          if lineLength < 67 then
            out.write(" " + blue)
            lineLength = lineLength + blue.size() + 1
          else
            out.write("\n" + blue)
            lineLength = blue.size()
          end
        else
          out.write("\n" + green + " " + blue)
          lineLength = green.size() + 1 + blue.size()
        end

        x = x + 1

        if (x < canvas.width) then
          if (lineLength < 67) then
            out.write(" ")
            lineLength = lineLength + 1
          else
            out.print("")
            lineLength = 0
          end
        end
      end

      out.print("")
      y = y + 1
      x = 0
      lineLength = 0
    end
