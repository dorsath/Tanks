require 'tanks/ground'
require 'tanks/tank'
require 'tanks/airplane'
require 'environment'

class Tanks < Talisman::Controller

  attr_reader :camera, :tank, :light, :ground

  def initialize(camera, tank, ground)
    @camera = camera
    @tank   = tank
    @ground = ground

    @time = time
    @dt   = 0
  end

  on key: "=" do
    camera.zoom_in
  end

  on key: "-" do
    camera.zoom_out
  end

  on key: "a" do
    tank.roll( 1 * dt)
  end

  on key: "d" do
    tank.roll(-1 * dt)
  end

  on key: "z" do
    tank.yaw( 1 * dt)
  end

  on key: "c" do
    tank.yaw(-1 * dt)
  end

  on key: "w" do
    tank.pitch(-1 * dt)
  end

  on key: "s" do
    tank.pitch( 1 * dt)
  end

  on key: "[" do
    tank.accelerate
  end

  on key: "]" do
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

    camera.follow_mouse(mouse_dx, mouse_dy)

    x = tank.matrix[3,0]
    z = tank.matrix[3,2]

    # tank.rotation.translate!(0,ground.location(x,z) - tank.matrix[3,1], 0)
    # p tank.matrix[3,1]

    # ground.location(x,z)
    @mouse_dx = @mouse_dy = 0
    @time = time
    # window.reset_pointer
  end

  def time
    Time.now.to_f * Adder::World.instance.time_multiplier
  end

  def dt
    (time - @time)
  end
end

sun   = Walker::Light.new
sun.position = [1, 1, 0]

ground = Ground.new
tank = Airplane.new
tank.position = [160,50,160]

Adder::World.instance.add_bodies(tank: tank)

$camera = camera = Walker::Camera.new( 5)
camera.follow_object = tank

window = Walker::Window.new(Tanks.new(camera,tank, ground))
# window.hide_cursor
window.views << Walker::CameraView.new(camera)
window.views << GroundView.new(ground)
window.views << AirplaneView.new(tank)
window.add_light_source(sun)


window.start

