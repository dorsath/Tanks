require 'tanks/models/tanks/simple'

class Tank < Adder::Body
  include Walker::Rotation

  def initialize
    super
    @draw_model = SimpleTank.new

    @engine_modes = (-2..5)
    @engine_mode = 0
    @speed_modifier = 2
    @traverse_speed = Math::PI / 4 # per second
  end

  def set_speed
    self.velocity = Vector[0, 0, @speed_modifier * @engine_mode, 0]
  end

  def turn_left(dt)
    rotation.yaw!( @traverse_speed * dt * (reverse? ?  1 : -1) )
  end

  def turn_right(dt)
    rotation.yaw!( @traverse_speed * dt * (reverse? ? -1 :  1) )
  end

  def reverse?
    @engine_mode < 0
  end

  def accelerate
    change_mode(@engine_mode + 1)
  end

  def decelerate
    change_mode(@engine_mode - 1)
  end

  def change_mode(new_mode)
    @engine_mode = new_mode if @engine_modes.include?(new_mode + 1)
    set_speed
  end

  def stop
    change_mode(0)
  end

  def draw
    @draw_model.draw
  end

end

class TankView < Walker::View
  def draw
    mult_matrix(@model.matrix)
    @model.draw


  end
end
