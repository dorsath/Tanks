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

  on key: "a" do
    tank.turn_left(dt)
  end

  on key: "d" do
    tank.turn_right(dt)
  end

  on key: "w" do
    tank.accelerate
  end

  on key: "s" do
    tank.decelerate
  end

  on key: " " do
    tank.stop
  end

  on key: "f" do
    window.enter_full_screen
  end

  on key: "F" do
    window.leave_full_screen
  end

  on key: "q" do
    exit
  end

  def on_tick
    Adder::World.instance.over(dt)
    # p spaceship.velocity

    @time = time
  end

  def time
    Time.now.to_f * Adder::World.instance.time_multiplier
  end

  def dt
    (time - @time)
  end
end

tank = Tank.new

Adder::World.instance.add_bodies(tank: tank)

$camera = camera = Walker::Camera.new( 5)
camera.follow_object = tank

window = Walker::Window.new(Tanks.new(camera,tank))
window.views << Walker::CameraView.new(camera)
window.views << GroundView.new(Ground.new)
window.views << TankView.new(tank)
window.add_light_source(Walker::Light.new)


window.start

