class Airplane < Adder::Body
  include Walker::Rotation

  def initialize
    super
    @draw_model = SimpleTank.new

    @engine_modes = (0..20)
    @engine_mode = 0
    @speed_modifier = 2
  end

  def set_speed
    self.velocity = Vector[0, 0, @speed_modifier * @engine_mode, 0]
  end

  def accelerate
    change_mode(@engine_mode + 1)
  end

  def decelerate
    change_mode(@engine_mode - 1)
  end

  def change_mode(new_mode)
    @engine_mode = new_mode if @engine_modes.include?(new_mode + 1)
    set_speed
  end

  def stop
    change_mode(0)
  end

  def roll(d)
    d *= 2
    rotation.roll!(d)
  end


  def yaw(d)
    rotation.yaw!(d)
  end

  def pitch(d)
    rotation.pitch!(d)
  end
end

class AirplaneView < Walker::View
  include Clynish

  def draw
    mult_matrix(@model.matrix)

    cockpit
    wings( 4)
    wings(-4)
    tail

    propellor
  end

  def cockpit
    Draw.new(GL_TRIANGLE_FAN) do |d|
      d.color(0,1,0)
      d.circle(0.2,36, 0, 0, 4) do |x,y|
        d.vertex(x,y,3.8)
      end
    end

    Draw.new(GL_TRIANGLE_STRIP) do |d|
      d.color(1,0,0)
      d.circle(0.2,36) do |x,y|
        d.vertex(x    ,y    ,3.8)
        d.vertex(x*2.0,y*2.0,0.0)
      end

      d.circle(0.2,36) do |x,y|
        d.vertex(x*2.0,y*2.0, 0.0)
        d.vertex(x    ,y    ,-3.0)
      end
    end

    Draw.new(GL_TRIANGLE_STRIP) do |d|
      d.color(1,1,1)
      d.circle(0.2,36) do |x,y|
        d.vertex(x,y + 0.4, 0  )
        d.vertex(x,y + 0.4,-0.2)
      end
    end

    Draw.new(GL_TRIANGLE_FAN) do |d|
      d.color(0,1,1)
      d.circle(0.2,36, 0, 0.4, 0.3) do |x,y|
        d.vertex(x,y + 0.4, 0  )
      end
    end
  end

  def wings(x)
    Draw.new(GL_QUADS) do |d|
      d.color(0,0,1)

      #top and bottom
      d.vertex(x,-0.05,2.3)
      d.vertex(x,-0.05,0.5)
      d.vertex(0, -0.1,0)
      d.vertex(0, -0.1,2.5)

      d.vertex(x, 0.05,2.3)
      d.vertex(x, 0.05,0.5)
      d.vertex(0,  0.1,0)
      d.vertex(0,  0.1,2.5)

      d.color(1,0,0)
      #frontwing
      d.vertex(x, 0.05,2.3)
      d.vertex(x,-0.05,2.3)
      d.vertex(0, -0.1,2.5)
      d.vertex(0,  0.1,2.5)

      #sidewing
      d.vertex(x, 0.05,2.3)
      d.vertex(x,-0.05,2.3)
      d.vertex(x,-0.05,0.5)
      d.vertex(x, 0.05,0.5)

      #backwing
      d.color(0,2,0)
      d.vertex(x,  0.05, 0.5)
      d.vertex(x, -0.05, 0.5)
      d.vertex(0, -0.1 , 0.0)
      d.vertex(0,  0.1 , 0.0)
    end
  end

  def tail
    Draw.new(GL_TRIANGLE_FAN) do |d|
      d.color(1,1,1)
      d.circle(0.8,36,0,0.0,-2.5) do |x,z|
        d.vertex(x*2.2,0.0,z * 0.8 - 2.5)
      end
    end

    Draw.new(GL_TRIANGLE_FAN) do |d|
      d.color(1,1,1)
      d.circle(0.8,36,0,0.1,-2.5) do |x,z|
        d.vertex(x*2.2,0.1,z * 0.8 - 2.5)
      end
    end

    Draw.new(GL_TRIANGLE_STRIP) do |d|
      d.color(0,1,0)
      d.circle(0.8,36) do |x,z|
        d.vertex(x*2.2,0.0,z * 0.8 - 2.5)
        d.vertex(x*2.2,0.1,z * 0.8 - 2.5)
      end
    end

    Draw.new(GL_QUADS) do |d|
      d.color(0,0,1)
      d.vertex(0, 0, -2.2)
      d.vertex(0, 1, -2.5)
      d.vertex(0, 1, -3.0)
      d.vertex(0, 0, -3.0)
    end
  end

  def propellor
    @r ||= 0
    @r += 20
    glRotate(@r,0,0,1)
    Draw.new(GL_TRIANGLE_FAN) do |d|
      d.color(1,1,1)
      d.circle(1,36,0,0,3.8) do |x,y|
        d.vertex(x * 0.05,y,3.8)
      end
    end
  end

end



