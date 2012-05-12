module Walker
  class Camera
    attr_accessor :follow_object

    include Rotation

    def initialize(zoom = 1)
      @zoom = zoom
      self.follow_object = false
      # roll(-Math::PI/2)
      # yaw(-Math::PI)
    end

    def zoom_in
      @zoom *= 0.9
    end

    def zoom_out
      @zoom *= 1.1
    end

    def roll(r)
      rotation.roll!(r)
    end

    def yaw(r)
      rotation.yaw!(r)
    end

    def pitch(r)
      rotation.pitch!(r)
    end

    # Change the matrix to allow for zooming
    def matrix
      (follow_object ? follow_object.matrix.inverse : Matrix.identity(4)) * rotation.matrix + rotation.translate(0,0,@zoom)
    end
  end
end
