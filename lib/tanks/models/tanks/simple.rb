class SimpleTank
  include Clynish
  include Gl, Glu, Glut

  def draw
    # glMaterial(GL_FRONT_AND_BACK, GL_DIFFUSE, [0.5, 0.5, 0.5, 0.5])
    glEnable( GL_COLOR_MATERIAL )
    glColor(0.8,0.4,0.4)
    # glutSolidSphere(1,36,36)
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
    glTranslate(0,0.5,0)
    glMultMatrix($camera.rotation.matrix.inverse * $camera.rotation.yaw(3.14))
    Draw.new(GL_TRIANGLE_STRIP) do |d|
      d.circle(0.05, 36) do |x, y|
        d.vertex(x, y, 0)
        d.vertex(x, y, 1.0)
      end
    end

    glutSolidSphere(0.25,36,36)

    # Draw.new(GL_TRIANGLE_STRIP) do |d|
    #   d.circle(0.25, 36) do |x, z|
    #     d.vertex(x    , 0.5 , z)
    #     d.vertex(x    , 0.75, z)
    #   end
    # end

    # Draw.new(GL_TRIANGLE_FAN) do |d|
    #   d.circle(0.25, 36, 0, 0.75, 0) do |x, z|
    #     d.vertex(x, 0.75, z)
    #   end
    # end

  end
end
