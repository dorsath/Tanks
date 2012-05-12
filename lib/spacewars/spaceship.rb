class Spaceship < Adder::Body

  attr_accessor :in_warp

  VMAX = 3e8 * 20  #max warp speed
  TURN_SPEED = 1.0

  include Walker::Rotation

  def warp_speed
    VMAX
  end

  def roll_left(dt)
    rotation.roll!(-TURN_SPEED * dt) unless in_warp
  end

  def roll_right(dt)
    rotation.roll!(TURN_SPEED * dt) unless in_warp
  end

  def yaw_left(dt)
    rotation.yaw!(-TURN_SPEED * dt) unless in_warp
  end

  def yaw_right(dt)
    rotation.yaw!(TURN_SPEED * dt) unless in_warp
  end

  def reset_rotation
    rotation.reset
  end

  def pitch_down(dt)
    rotation.pitch!( TURN_SPEED/2 * dt) unless in_warp
  end

  def pitch_up(dt)
    rotation.pitch!(-TURN_SPEED/2 * dt) unless in_warp
  end

  def accelerate
    self.velocity -= Vector[0,0, 1e4, 0] unless in_warp
  end

  def brake
    self.velocity += Vector[0,0, 1e4, 0] unless in_warp
  end

  def disengage_warp
    unless stopping?
      @stop = true

      @time_since_engage = Time.now.to_f
    end
  end

  def engage_warp
    @stop = false

    self.in_warp = true

    @time_since_engage = Time.now.to_f
  end

  def calculate_warp_speed
    t    = Time.now.to_f - @time_since_engage
    k    = 0.5 #1/versnelling

    if stopping?
      self.velocity = Vector[0, 0, -(velocity[2].abs * Math.exp(-t * k)), 0]
      out_of_warp if velocity[2].abs < 1000
    else
      self.velocity = Vector[0, 0, -(VMAX - VMAX * Math.exp(-t * k)), 0]
    end
  end

  def out_of_warp
    self.in_warp = false
  end

  def stopping?
    @stop
  end


end
