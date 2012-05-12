module Clynish
  class Draw
    include Gl, Glu, Glut

    attr_accessor :draw_type

    def initialize draw_type
      self.draw_type = draw_type
      glBegin(draw_type)
      yield self if block_given?
      glEnd
    end

    def vertex(x, y, z = 0)
      glVertex(x, y, z)
    end

    def color(*args)
      glColor(*args)
    end

    def circle(radius, z_slices, x = 0, y = 0, z = 0)

      # Draw.new(GL_TRIANGLE_FAN) do |draw|
      #   draw.circle(5, 36) do |x ,y|
      #     draw.vertex(x, y, 0)
      #   end
      # end

      vertex(x, y, z) if draw_type == GL_TRIANGLE_FAN

      step = 2 * Math::PI / z_slices

      (z_slices + 1).times do |i|
        deg = i * step
        x = Math.cos(deg) * radius
        y = Math.sin(deg) * radius

        yield x, y, deg
      end
    end
  end
end
