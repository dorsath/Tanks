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
  end

  def point(x,z)
    # p [x,z,(x/10 + z/10 * width).round]
    level[(x + z * width).round]/3000
  end

  def location(x,z)
    x = x/10
    z = z/10

#
#     p "---------------------"
    # p [x.floor, x.ceil]
    # p "#{point(x.floor, z.ceil) } + #{point(x.ceil, z.ceil) }"
    # p "#{point(x.floor, z.floor)} + #{point(x.ceil, z.floor)}"

    # p point(x.ceil, z.ceil) - point(x.floor, z.ceil)
    # (x - x.floor) * ( point(x.ceil, z.ceil) - point(x.floor, z.ceil) )
    (z - z.floor) * ( point(x.floor, z.ceil) - point(x.floor, z.floor) ) + point(x.floor, z.floor)
    # (z - z.floor) * ( point(x.ceil, z.ceil) - point(x.floor, z.ceil) ) + point(x.floor, z.ceil)
  end

end


class GroundView < Walker::View
  include Clynish

  def draw
    mult_matrix(@model.matrix)
    glColor(1,1,1)
    # glMaterial(GL_FRONT_AND_BACK, GL_EMISSION, [0.0, 0.0, 0.0, 1.0])
    # glMaterial(GL_FRONT_AND_BACK, GL_SPECULAR, [1.0, 1.0, 1.0, 1.0])
    # tree

    ground


    glPopMatrix
    air
    glPushMatrix
  end

  def air
    glutSolidSphere(1200,36,36)
  end

  def ground
    texture = Walker::Textures.instance.find(:grass,2)
    glEnable(GL_TEXTURE_2D);
    glBindTexture(GL_TEXTURE_2D, texture)

    glScale(40,10,40)
    height_multiplier = 30000 #lower is higher :D
    Draw.new(GL_TRIANGLES) do |d|
      (@model.level.size - @model.width - 1).times do |i|

        d.texcoord(0,1)
        d.vertex(i - (i/ @model.width).floor * @model.width    , @model.level[i]/height_multiplier                       , (i / @model.width).floor)
        d.texcoord(1,1)
        d.vertex(i - (i/ @model.width).floor * @model.width    , @model.level[i + (@model.width)]/height_multiplier      , (i / @model.width).floor + 1)
        d.texcoord(1,0)
        d.vertex(i - (i/ @model.width).floor * @model.width + 1, @model.level[i + 1]/height_multiplier                   , (i / @model.width).floor)

        d.texcoord(0,1)
        d.vertex(i - (i/ @model.width).floor * @model.width + 1, @model.level[i + 1]/height_multiplier                   , (i / @model.width).floor)
        d.texcoord(0,0)
        d.vertex(i - (i/ @model.width).floor * @model.width    , @model.level[i + (@model.width)]/height_multiplier      , (i / @model.width).floor + 1)
        d.texcoord(1,1)
        d.vertex(i - (i/ @model.width).floor * @model.width + 1, @model.level[i + (@model.width) + 1]/height_multiplier  , (i / @model.width).floor + 1)
      end
    end

    glDisable(GL_TEXTURE_2D);
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
