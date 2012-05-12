require 'rmagick'
require 'singleton'

module Walker
  class Textures
    include Gl, Glu, Glut, Singleton

    def initialize
      @textures = []
      @hash     = {}

    end

    def loaded_textures
      @hash.keys
    end

    def find key, filter = 0
      if @hash[key].nil?
        raise "No texture loaded with this name"
      else
        @textures[@hash[key]] + filter
      end
    end

    def load_all
      file_names = Dir["textures/*"].map { |file| file if file.split('.').last == 'bmp' }.compact

      file_names.each_with_index do |f, index|
        @hash[f.split('/')[1][(0..-5)].gsub('.','_').to_sym] = (index * 3)
      end

      @textures = glGenTextures(file_names.size * 3)

      file_names.size.times do |i|
        image = Magick::Image::read(file_names[i]).first
        load(@textures[(i * 3)],image.to_blob,image.rows, image.columns)
      end
    end

    def load texture, image_binary, width, height
      glBindTexture(GL_TEXTURE_2D, texture) # Bind The Texture

      glTexEnvf( GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE )

      glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_NEAREST);
      glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_NEAREST);
      glTexImage2D(GL_TEXTURE_2D, 0, 3, width, height, 0, GL_BGR, GL_UNSIGNED_BYTE, image_binary);

      glBindTexture(GL_TEXTURE_2D, texture + 1);
      glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
      glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);
      glTexImage2D(GL_TEXTURE_2D, 0, 3, width, height, 0, GL_BGR, GL_UNSIGNED_BYTE, image_binary);

      glBindTexture(GL_TEXTURE_2D, texture + 2);
      glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
      glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR_MIPMAP_NEAREST);
      gluBuild2DMipmaps(GL_TEXTURE_2D, 3, width, height, GL_BGR, GL_UNSIGNED_BYTE, image_binary);

      texture
    end
  end
end
