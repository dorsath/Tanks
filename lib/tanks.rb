require 'tanks/ground'
require 'tanks/tank'

class Tanks < Talisman::Controller

  attr_reader :camera

  def initialize(camera, tank)
    @camera = camera
    @tank   = tank
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

tank = Tank.new

$camera = camera = Walker::Camera.new( 5)

window = Walker::Window.new(Tanks.new(camera,tank))
window.views << Walker::CameraView.new(camera)
window.views << GroundView.new(Ground.new)
window.views << TankView.new(tank)
window.add_light_source(Walker::Light.new)



window.start

