use ".."
use "files"


class Projectile
  let position: Tuple
  let velocity: Tuple

  new create(position': Tuple, velocity': Tuple) =>
    position = position'
    velocity = velocity'


class Environment
  let gravity: Tuple
  let wind: Tuple

  new create(gravity': Tuple, wind': Tuple) =>
    gravity = gravity'
    wind = wind'


actor Main
  new create(env: Env) =>
    // Projectile starts one unit above the origin.
    let start_pos = Tuple.point(0, 1, 0)
    // velocity is normalized to 1 unit/tick.
    let start_vel = Tuple.vector(1, 1.2, 0).normalize()
    var projectile = Projectile(start_pos, start_vel)

    let gravity = Tuple.vector(0, -0.08, 0)
    let wind = Tuple.vector(-0.02, 0, 0)
    let environment = Environment(gravity, wind)

    var frame: U32 = 1
    let canvas: Canvas = Canvas(110, 80)

    while projectile.position.y >= 0 do
      env.out.print(frame.string() + ": " + projectile.position.string())

      projectile = tick(environment, projectile)
      try
        canvas.write_pixel(
          USize.from[F32](projectile.position.x * 10),
          canvas.height - USize.from[F32](projectile.position.y * 10),
          Color(0.8, 0, 0))?
      end
      frame = frame + 1
    end
    render(env, canvas)

  fun tick(environment: Environment, projectile: Projectile): Projectile =>
    let position = projectile.position + projectile.velocity
    let velocity = projectile.velocity + environment.gravity + environment.wind

    Projectile(position, velocity)

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
