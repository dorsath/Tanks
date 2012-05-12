require 'matrix'
require 'mathn'

module Walker
  module Rotation

    def rotation
      @rotations ||= Rotator.new
    end

    def matrix
      rotation.matrix
    end

    class Rotator

      M = Matrix
      include Math

      attr_accessor :matrix

      def initialize
        reset
      end

      def reset
        self.matrix = yaw(0) * roll(0) * pitch(0)
      end

      def roll(r)
        M[
          [  cos(r), -sin(r), 0, 0 ],
          [  sin(r),  cos(r), 0, 0 ],
          [       0,       0, 1, 0 ],
          [       0,       0, 0, 1 ]
        ]
      end

      def roll!(r)
        self.matrix = roll(r) * matrix
      end

      def yaw(r)
        M[
          [  cos(r), 0, sin(r), 0 ],
          [       0, 1,      0, 0 ],
          [ -sin(r), 0, cos(r), 0 ],
          [       0, 0,      0, 1 ]
        ]
      end

      def yaw!(r)
        self.matrix = yaw(r) * matrix
      end

      def pitch(r)
        M[
          [  1,      0,       0, 0 ],
          [  0, cos(r), -sin(r), 0 ],
          [  0, sin(r),  cos(r), 0 ],
          [  0,      0,       0, 1 ]
        ]
      end

      def pitch!(r)
        self.matrix = pitch(r) * matrix
      end

      def translate(x, y, z, w = 0)
        M[
          [ 0, 0, 0, 0],
          [ 0, 0, 0, 0],
          [ 0, 0, 0, 0],
          [ x, y, z, 0]
        ]
      end

      def translate!(x, y, z, w = 0)
        self.matrix += translate(x, y, z) * matrix
      end

      def rotate(r, x, y, z, w = 0)
        pitch(r*x) * yaw(r*y) * roll(r*z)
      end

      def rotate!(r, x, y, z, w = 0)
        pitch!(r*x)
        yaw!(r*y)
        roll!(r*z)
      end

    end

  end
end
