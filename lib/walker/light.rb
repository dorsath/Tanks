module Walker
  class Light
    include Gl, Glu, Glut

    attr_accessor :attenuation, :ambient_color, :diffuse_color, :specular_color, :position, :type, :number

    def initialize
      default_values!

      yield self if block_given?
    end

    def default_values!
      self.attenuation     = {:constant => 0, :linear => 1.0, :quadratic => 0}
      self.ambient_color   = [0.2, 0.2, 0.2, 1]
      self.diffuse_color   = [0.5, 0.5, 0.5, 1.0]
      self.specular_color  = [0.2, 0.2, 0.2, 1.0]
      self.position        = [-1.2, -1.2, -4.0]
      self.type            = :point
    end

    def gl_light
      eval("GL_LIGHT#{number}")
    end

    def activate
      p ambient_color

      glEnable(gl_light)
      glLightfv(gl_light, GL_AMBIENT, ambient_color)
      glLightfv(gl_light, GL_DIFFUSE, diffuse_color)
      glLightfv(gl_light, GL_SPECULAR, specular_color)
      glLightfv(gl_light, GL_POSITION, position)
    end
  end
end
