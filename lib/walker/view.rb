module Walker
  class View
    include Gl, Glu, Glut

    def initialize(model)
      @model = model
    end

    def draw!
      glPushMatrix
      draw
      glPopMatrix
    end

    def draw
      raise NotImplentedError,
        "View objects must define a draw method"
    end

    def draw_axis
      glBegin(GL_LINES)
      glColor(1,0,0)
      glVertex(0, 0, 0)
      glVertex(0,5e2, 0)

      glColor(0,1,0)
      glVertex(0, 0, 0)
      glVertex(5e2,0, 0)

      glColor(0,0,1)
      glVertex(0, 0, 0)
      glVertex(0, 0,5e2)
      glEnd
    end

    def mult_matrix matrix
      glMultMatrix(matrix * $camera.matrix)
    end

    def scale(r)
      glScale(r,r,r)
    end

  end
end
