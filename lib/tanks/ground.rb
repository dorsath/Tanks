class Ground < Adder::Body
  include Walker::Rotation

end


class GroundView < Walker::View
  include Clynish

  def draw
    # glMaterial(GL_FRONT_AND_BACK, GL_EMISSION, [1.0, 1.0, 1.0, 1.0])

    mult_matrix(@model.matrix)

    glScale(4,4,4)
    Draw.new(GL_QUADS) do |draw|
      draw.color(0.2,1.0,0.2)
      draw.vertex(-1,0,-1)
      draw.vertex( 1,0,-1)
      draw.vertex( 1,0, 1)
      draw.vertex(-1,0, 1)

      # draw.vertex(-200,0,-200)
      # draw.vertex( 200,0,-200)
      # draw.vertex( 200,0, 200)
      # draw.vertex(-200,0, 200)
    end

    # Draw.new(GL_TRIANGLE_FAN) do |draw|
    #   draw.circle(5, 36) do |x ,y|
    #     draw.vertex(x, y, 0)
    #   end
    # end


  end
end
