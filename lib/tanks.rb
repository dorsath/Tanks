require 'tanks/ground'
require 'tanks/tank'

class Tanks < Talisman::Controller

  attr_reader :camera
  attr_reader :tank

  def initialize(camera, tank)
    @camera = camera
    @tank   = tank

    @time = time
    @dt   = 0
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

  on key: "w" do
    tank.accelerate
  end

  on key: "s" do
    tank.decelerate
  end

  on key: "q" do
    exit
  end

  def on_tick
    @dt = (time - @time)
    Adder::World.instance.over(@dt)
    # p spaceship.velocity

    @time = time
  end

  def time
    Time.now.to_f * Adder::World.instance.time_multiplier
  end
end

tank = Tank.new

Adder::World.instance.add_bodies(tank: tank)

$camera = camera = Walker::Camera.new( 5)

window = Walker::Window.new(Tanks.new(camera,tank))
window.views << Walker::CameraView.new(camera)
window.views << GroundView.new(Ground.new)
window.views << TankView.new(tank)
window.add_light_source(Walker::Light.new)


window.start

