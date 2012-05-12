class Fuselage < Walker::View
  include Clynish

  def draw
    mult_matrix(@model.matrix)
    # glMaterial(GL_FRONT_AND_BACK, GL_DIFFUSE, [0.8, 0.8, 0.8, 1.0])
    if @model.in_warp && @model.velocity.magnitude
      glScale(1, 1, @model.velocity.magnitude/@model.warp_speed + 1)
    end
    scale(1e4)

    glMaterial(GL_FRONT_AND_BACK, GL_EMISSION, [0.0, 0.0, 0.0, 0.0])

    glEnable(GL_COLOR_MATERIAL)

    draw_middle
    draw_engine( 4,1, 6)
    draw_engine(-4,1, 6)
    draw_engine_connections
    draw_dish_connection

    draw_dish

    glDisable(GL_COLOR_MATERIAL)
  end

  def draw_dish
    #bottom dish
    size = 5
    Draw.new(GL_TRIANGLE_FAN) do |draw|
      draw.color(0.3, 0.3, 0.3)
      draw.circle(size, 36, 0, -0.8, 0) do |x,y|
        draw.vertex(x, 0, y)
      end
    end

    #dish width
    Draw.new(GL_TRIANGLE_STRIP) do |draw|
      draw.color(0.5, 0.5, 0.5)
      draw.circle(size,36) do |x,y|
        glVertex(x, 0, y)
        glVertex(x, 1, y)
      end
    end

    #top dish
    Draw.new(GL_TRIANGLE_FAN) do |draw|
      draw.color(0.5, 0.5, 0.5)
      draw.circle(size,36,0,1,0) do |x,y|
        draw.vertex(x, 1, y)
      end
    end

    #second row
    Draw.new(GL_TRIANGLE_STRIP) do |draw|
      inner_size = 1.1
      draw.circle(size,36,0,1,0) do |x,y,deg|
        draw.color(0.4, 0.4, 0.4)
        draw.vertex(Math.cos(deg)        * size       ,1  , Math.sin(deg       ) * size)
        draw.color(0.3, 0.3, 0.3)
        draw.vertex(Math.cos(deg       ) * inner_size ,1.5, Math.sin(deg       ) * inner_size)
      end
    end

    #little bubble on top
    glTranslate(0, 0.5, 0)
    glutSolidSphere(1.5,36,36)

  end

  def draw_middle

    #tube
    size = 0.7
    y = -3
    z =  1
    Draw.new(GL_TRIANGLE_STRIP) do |draw|
      draw.color(0.3, 0.3, 0.3)
      draw.circle(size, 36, 0, y, z) do |x0,y0|
        draw.vertex(x0, y0 + y, z)
        draw.vertex(x0, y0 + y, 7 + z)
      end
    end

    #circle at end
    Draw.new(GL_TRIANGLE_FAN) do |draw|
      draw.color(0,0,0)
      draw.circle(size, 36, 0, y, 7 + z) do |x0, y0|
        draw.vertex(x0, y0 + y, 7 + z)
      end
    end


    #circle at front

    Draw.new(GL_TRIANGLE_FAN) do |draw|
      draw.color(0.5,0.5,0.5)
      draw.circle(size, 36, 0, y, z) do |x0, y0|
        draw.vertex(x0, y0 + y, z)
      end
    end
  end

  def draw_engine(x, y, z)
    size = 0.5
    Draw.new(GL_TRIANGLE_STRIP) do |draw|
      draw.color(0.3, 0.3, 0.3)
      draw.circle(size, 36,x, y, z) do |x0, y0|
        draw.vertex(x0 + x, y0 + y, z)
        draw.vertex(x0 + x, y0 + y, 5 + z)
      end
    end

    #red front circle
    Draw.new(GL_TRIANGLE_FAN) do |draw|
      draw.color(0.8,0.2,0.2)
      draw.circle(size,36,x,y,z) do |x0,y0|
        draw.vertex(x0 + x, y0 + y, z)
      end
    end

    #black end circle
    z += 5
    Draw.new(GL_TRIANGLE_FAN) do |draw|
      draw.color(0.8,0.2,0.2)
      draw.circle(size,36,x,y,z) do |x0,y0|
        draw.vertex(x0 + x, y0 + y, z)
      end
    end
  end

  def draw_engine_connections
    #tube
    x = 0
    y = -3
    z = 7

    size = 0.2
    Draw.new(GL_TRIANGLE_STRIP) do |draw|
      draw.color(0.2,0.2,0.2)
      draw.circle(size, 36, x,y,z) do |x0, z0|
        glVertex(x0 + x    , y    , z0 + z)
        glVertex(x0 + x + 4, y + 4, z0 + z)
      end
    end

    Draw.new(GL_TRIANGLE_STRIP) do |draw|
      draw.color(0.2,0.2,0.2)
      draw.circle(size, 36, x,y,z) do |x0, z0|
        glVertex(x0 + x    , y    , z0 + z)
        glVertex(x0 + x - 4, y + 4, z0 + z)
      end
    end
  end

  def draw_dish_connection
    x = 0
    y = -3
    z = 3

    size = 0.5
    Draw.new(GL_TRIANGLE_STRIP) do |draw|
      draw.color(0.2,0.2,0.2)
      draw.circle(size,36,x,y,z) do |x0,z0|
        glVertex(x0 + x, y    , z0 * 2 + z)
        glVertex(x0 + x, y + 4, z0 * 2 - 2 + z)
      end
    end
  end
end
