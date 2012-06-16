require 'tanks/ground'

class Tanks < Talisman::Controller

  attr_reader :camera

  def initialize(camera)
    @camera = camera
  end

  on key: "=" do
    camera.zoom_in
  end

  on key: "-" do
    camera.zoom_out
  end

  on key: "h" do
    camera.yaw(-0.01)
  end

  on key: "j" do
    camera.pitch( 0.01)
  end

  on key: "k" do
    camera.pitch(-0.01)
  end

  on key: "l" do
    camera.yaw( 0.01)
  end

  on key: "q" do
    exit
  end
end


$camera = camera = Walker::Camera.new( -5)

window = Walker::Window.new(Tanks.new(camera))
window.views << Walker::CameraView.new(camera)
window.views << GroundView.new(Ground.new)
window.add_light_source(Walker::Light.new)



window.start

