use ".."
use "files"


class Projectile
  let position: Tuple
  let velocity: Tuple

  new create(position': Tuple, velocity': Tuple) =>
    position = position'
    velocity = velocity'

  new tick(projectile: Projectile, environment: Environment) =>
    position = projectile.next()
    velocity = projectile.velocity + environment.total()

  fun next(): Tuple =>
    position + velocity


class Environment
  let gravity: Tuple
  let wind: Tuple

  new create(gravity': Tuple, wind': Tuple) =>
    gravity = gravity'
    wind = wind'

  fun total(): Tuple =>
    gravity + wind


actor Main
  new create(env: Env) =>
    // Projectile starts one unit above the origin.
    let start_pos = Tuple.point(0, 1, 0)
    // velocity is normalized to 1 unit/tick.
    let start_vel = Tuple.vector(1, 1.8, 0).normalize() * 11.25
    var projectile = Projectile(start_pos, start_vel)

    let gravity = Tuple.vector(0, -0.1, 0)
    let wind = Tuple.vector(-0.01, 0, 0)
    let environment = Environment(gravity, wind)

    var frame: U32 = 1
    let canvas: Canvas = Canvas(900, 550)

    while projectile.position.y >= 0 do
      env.out.print(frame.string() + ": " + projectile.position.string())

      projectile = Projectile.tick(projectile, environment)
      draw_point(canvas, projectile.position)
      frame = frame + 1
    end
    render(env, canvas)

  fun draw_point(canvas: Canvas, position: Tuple) =>
    let color = Color(0.8, 0, 0)

    let x = USize.from[F32](position.x)
    let y = canvas.height - USize.from[F32](position.y)

    try
      canvas.write_pixel(x - 1, y - 1, color)?
      canvas.write_pixel(x,     y - 1, color)?
      canvas.write_pixel(x + 1, y - 1, color)?
      canvas.write_pixel(x - 1, y, color)?
      canvas.write_pixel(x,     y, color)?
      canvas.write_pixel(x + 1, y, color)?
      canvas.write_pixel(x - 1, y + 1, color)?
      canvas.write_pixel(x,     y + 1, color)?
      canvas.write_pixel(x + 1, y + 1, color)?
    end

  fun render(env: Env, canvas: Canvas) =>
    try
      let path = FilePath(env.root as AmbientAuth, "./path.ppm")?
      let file = recover File(path) end

      if file.errno() is FileOK then
        PPM.from_canvas(canvas, FileStream(consume file))?
        env.out.print("File written")
      end
    else
      env.out.print("Error somewhere")
    end
