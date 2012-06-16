class SimpleTank
  include Clynish
  include Gl, Glu, Glut

  def draw
    glMaterial(GL_FRONT_AND_BACK, GL_DIFFUSE, [0.0, 0.0, 0.0, 0.0])
    glColor(0.8,0.4,0.4)
    body
    turret
  end

  def body
    Draw.new(GL_QUADS) do |d|
      #front
      d.color(0.8,0.3,0.3)
      d.vertex(-0.5,  0,1)
      d.vertex(-0.5,0.5,1)
      d.vertex( 0.5,0.5,1)
      d.vertex( 0.5,0  ,1)

      #back
      d.vertex(-0.5,  0,-1)
      d.vertex(-0.5,0.5,-1)
      d.vertex( 0.5,0.5,-1)
      d.vertex( 0.5,0  ,-1)

      #sides
      d.vertex( 0.5,   0, -1)
      d.vertex( 0.5, 0.5, -1)
      d.vertex( 0.5, 0.5,  1)
      d.vertex( 0.5,   0,  1)


      d.vertex(-0.5,   0, -1)
      d.vertex(-0.5, 0.5, -1)
      d.vertex(-0.5, 0.5,  1)
      d.vertex(-0.5,   0,  1)

      #top
      d.vertex(-0.5, 0.5, -1)
      d.vertex( 0.5, 0.5, -1)
      d.vertex( 0.5, 0.5,  1)
      d.vertex(-0.5, 0.5,  1)


    end
  end

  def turret
    Draw.new(GL_TRIANGLE_STRIP) do |d|
      d.circle(0.25, 36) do |x, z|
        d.vertex(x    , 0.5 , z)
        d.vertex(x    , 0.75, z)
      end
    end

    Draw.new(GL_TRIANGLE_FAN) do |d|
      d.circle(0.25, 36, 0, 0.75, 0) do |x, z|
        d.vertex(x, 0.75, z)
      end
    end

    #gun
    Draw.new(GL_TRIANGLE_STRIP) do |d|
      d.circle(0.05, 36) do |x, y|
        d.vertex(x, 0.6 + y, 0)
        d.vertex(x, 0.6 + y, 1.0)
      end
    end
  end
end
