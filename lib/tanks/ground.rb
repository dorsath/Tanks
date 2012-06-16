class Ground < Adder::Body
  include Walker::Rotation

  attr_accessor :texture

  def initialize
    self.texture = :tree
  end

end


class GroundView < Walker::View
  include Clynish

  def draw
    mult_matrix(@model.matrix)
    # tree
    ground
  end


  def ground
    # glMaterial(GL_FRONT_AND_BACK, GL_EMISSION, [1.0, 1.0, 1.0, 1.0])

    texture = Walker::Textures.instance.find(:grass,2)

    glColor(1,1,1,0)
    glEnable(GL_TEXTURE_2D);
    glBindTexture(GL_TEXTURE_2D, texture)

    glScale(20,4,20)
    Draw.new(GL_QUADS) do |draw|
      draw.texcoord(0, 8)
      draw.vertex(-1,0,-1)
      draw.texcoord(8, 8)
      draw.vertex( 1,0,-1)
      draw.texcoord(8, 0)
      draw.vertex( 1,0, 1)
      draw.texcoord(0, 0)
      draw.vertex(-1,0, 1)
    end
    glDisable(GL_TEXTURE_2D);
  end

  def tree
    texture = Walker::Textures.instance.find(:crate,2)

    glEnable(GL_TEXTURE_2D);


    glBindTexture(GL_TEXTURE_2D, texture)
    Draw.new(GL_QUADS) do |draw|

      draw.texcoord(0, 1)
      draw.vertex(-1, 2, 0)

      draw.texcoord(1, 1)
      draw.vertex( 1, 2, 0)

      draw.texcoord(1, 0)
      draw.vertex( 1, 0, 0)

      draw.texcoord(0, 0)
      draw.vertex(-1, 0, 0)

    end

    glDisable(GL_TEXTURE_2D);
    # glMaterial(GL_FRONT_AND_BACK, GL_EMISSION, [0.5, 0.5, 0.5, 0.5])
  end

end
