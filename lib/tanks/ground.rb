class Ground < Adder::Body
  include Walker::Rotation
  include Magick

  attr_accessor :texture
  attr_reader :width, :height, :level

  def initialize
    self.texture = :tree

    load_level(:level2)
  end

  def load_level(filename)
    @level = []
    world = ImageList.new("maps/#{filename}.bmp")

    @width  = world.rows    - 1
    @height = world.columns - 1

    data = world.view(0,0,@height,@width)
    @height.times do |width|
      @width.times do |height|
        @level << data[width][height].red
      end
    end
    p level[4065]
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
    glTranslate(-@model.width/0.2,0,-@model.height/0.2)
    glScale(10,1,10)
    height_multiplier = 25000 #lower is higher :D
    Draw.new(GL_TRIANGLES) do |d|
      (@model.level.size - 2 * @model.width).times do |i|
        d.vertex(i - (i/ @model.width).floor * @model.width    , @model.level[i]/height_multiplier                   , (i / @model.width).floor)
        d.vertex(i - (i/ @model.width).floor * @model.width    , @model.level[i + (@model.width)]/height_multiplier  , (i / @model.width).floor + 1)
        d.vertex(i - (i/ @model.width).floor * @model.width + 1, @model.level[i + 1]/height_multiplier               , (i / @model.width).floor)

        d.vertex(i - (i/ @model.width).floor * @model.width + 1, @model.level[i + 1]/height_multiplier                   , (i / @model.width).floor)
        d.vertex(i - (i/ @model.width).floor * @model.width    , @model.level[i + (@model.width)]/height_multiplier      , (i / @model.width).floor + 1)
        d.vertex(i - (i/ @model.width).floor * @model.width + 1, @model.level[i + (@model.width) + 1]/height_multiplier  , (i / @model.width).floor + 1)
      end
    end
  end

  def old
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
