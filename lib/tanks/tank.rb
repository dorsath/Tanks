require 'tanks/models/tanks/simple'

class Tank < Adder::Body
  include Walker::Rotation

  def initialize
    super
    @draw_model = SimpleTank.new
  end

  def accelerate
    self.velocity = Vector[0, 0, 2, 0]
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
