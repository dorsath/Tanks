require 'singleton'

module Adder
  class World
    include Singleton

    attr_accessor :bodies, :gravity, :time_multiplier

    def initialize
      self.bodies = {}
      self.gravity = false
      self.time_multiplier = 1
    end

    def add_bodies hash
      hash.each do |name, body|
        self.bodies[name] = body
      end
    end

    def over dt
      bodies.each do |name, body|
        body.calculate(dt)
      end
    end

  end
end
