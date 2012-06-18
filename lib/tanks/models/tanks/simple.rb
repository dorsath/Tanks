class SimpleTank
  include Clynish
  include Gl, Glu, Glut

  def initialize
    @tracks_rotation = 0
    @time = time
  end

  def time
    Time.now.to_f * Adder::World.instance.time_multiplier
  end

  def dt
    (time - @time)
  end

  def draw(velocity)
    # glMaterial(GL_FRONT_AND_BACK, GL_DIFFUSE, [0.5, 0.5, 0.5, 0.5])
    glEnable(GL_COLOR_MATERIAL)
    glColor(0.4,0.4,0.4)
    # glutSolidSphere(1,36,36)

    glTranslate(0,0.01,0)
    body
    tracks(-1.5, velocity)
    tracks( 1.0, velocity)
    wheels( 1.25)
    wheels(-1.25)
    turret

    @time = time
  end

  def wheels(x)
    Draw.new(GL_TRIANGLE_FAN) do |d|
      d.circle(1, 36, x, 1, 1.57) do |z,y|
        d.vertex(x, 1 + y, 1.57 + z)
      end
    end

    Draw.new(GL_TRIANGLE_FAN) do |d|
      d.circle(1, 36, x, 1,-1.57) do |z,y|
        d.vertex(x, 1 + y,-1.57 + z)
      end
    end
  end

  def tracks(x, velocity)
    steps = 20
    step_size = 2.0 / steps

    @tracks_rotation += velocity * dt / (4 * Math::PI)
    @tracks_rotation = 0 if @tracks_rotation > step_size || @tracks_rotation < -step_size


    Draw.new(GL_QUADS) do |d|
      steps.times do |r|
        v = ( r.to_f * step_size) + @tracks_rotation
        # p tracks_height_function(r.to_f * step_size)
        d.color(0.50,0.50,0.50)
        d.vertex(x + 0.5, 1 + height_function(v)              , width_function(v)            )
        d.vertex(x + 0.5, 1 + height_function(v + step_size/2), width_function(v + step_size/2))
        d.vertex(x      , 1 + height_function(v + step_size/2), width_function(v + step_size/2))
        d.vertex(x      , 1 + height_function(v)              , width_function(v)            )

        d.color(0.25,0.25,0.25)
        d.vertex(x + 0.5, 1 + height_function(v)              , width_function(v)            )
        d.vertex(x + 0.5, 1 + height_function(v + step_size), width_function(v + step_size))
        d.vertex(x      , 1 + height_function(v + step_size), width_function(v + step_size))
        d.vertex(x      , 1 + height_function(v)              , width_function(v)            )
        # d.vertex(width_function(v), height_function(v))
        # d.vertex(v + Math::PI, height_function(v))
      end
    end

  end

  def height_function(theta)
    case(theta)
    when(-0.25..0.25), (1.75..2.25)
      Math.sin(theta * 2 * Math::PI)
    when(0.25..0.75), (2.25..2.75)
      1
    when(0.75..1.25)
      -Math.sin(theta * 2 * Math::PI)
    when(1.25..1.75)
      -1
    else 5
    end
  end

  def width_function(theta)
    case(theta)
    when(-0.25..0.25), (1.75..2.25)
      -1.57 - Math.cos(theta * 2 * Math::PI)
    when(0.25..0.75), (2.25..2.75)
      -1.57 + (theta - 0.25) * 2 * Math::PI
    when(0.75..1.25)
      1.57 + Math.cos(theta * 2 * Math::PI)
    when(1.25..1.75)
      1.57 - (theta - 1.25) * 2 * Math::PI
    else 5
    end
  end

  def body
    Draw.new(GL_QUADS) do |d|
      #front
      d.color(0.3,0.3,0.3)
      d.vertex(-1.0,0.5,2)
      d.vertex(-1.0,1.5,2)
      d.vertex( 1.0,1.5,2)
      d.vertex( 1.0,0.5,2)

      #back
      d.vertex(-1.0,0.5,-2)
      d.vertex(-1.0,1.5,-2)
      d.vertex( 1.0,1.5,-2)
      d.vertex( 1.0,0.5,-2)

      #bottom
      d.vertex( 1.0, 0.5, -2)
      d.vertex(-1.0, 0.5, -2)
      d.vertex(-1.0, 0.5,  2)
      d.vertex( 1.0, 0.5,  2)

      #top
      d.vertex( 1.0, 1.5,  2)
      d.vertex( 1.0, 2.0,  1)
      d.vertex(-1.0, 2.0,  1)
      d.vertex(-1.0, 1.5,  2)

      d.vertex( 1.0, 1.5, -2)
      d.vertex( 1.0, 2.0, -1)
      d.vertex(-1.0, 2.0, -1)
      d.vertex(-1.0, 1.5, -2)

      d.vertex( 1.0, 2.0, -1)
      d.vertex( 1.0, 2.0,  1)
      d.vertex(-1.0, 2.0,  1)
      d.vertex(-1.0, 2.0, -1)
    end

    Draw.new(GL_POLYGON) do |d|

      d.color(0.5,0.5,0.5)
      d.vertex( 1.0, 0.5, -2)
      d.vertex( 1.0, 1.5, -2)
      d.vertex( 1.0, 2.0, -1)
      d.vertex( 1.0, 2.0,  1)
      d.vertex( 1.0, 1.5,  2)
      d.vertex( 1.0, 0.5,  2)
    end

    Draw.new(GL_POLYGON) do |d|

      d.color(0.5,0.5,0.5)
      d.vertex(-1.0, 0.5, -2)
      d.vertex(-1.0, 1.5, -2)
      d.vertex(-1.0, 2.0, -1)
      d.vertex(-1.0, 2.0,  1)
      d.vertex(-1.0, 1.5,  2)
      d.vertex(-1.0, 0.5,  2)
    end

  end

  def turret
    glTranslate(0,2.0,0)
    # glMultMatrix($camera.rotation.matrix.inverse * $camera.rotation.yaw(3.14))
    Draw.new(GL_TRIANGLE_STRIP) do |d|
      d.circle(0.10, 36) do |x, y|
        d.vertex(x, y + 0.2, 0)
        d.vertex(x, y + 0.2, 3.0)
      end
    end

    glutSolidSphere(0.75,36,36)

  end
end
