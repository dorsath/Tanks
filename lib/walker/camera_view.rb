module Walker
  class CameraView < View

    def draw!
      glMultMatrix(Matrix.identity(4))
    end

  end
end
