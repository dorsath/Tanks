class CelestialBody < Adder::Body
  attr_accessor :radius, :texture

  def initialize hash = {}
    self.radius  = hash[:radius] || 2e6
    self.texture = hash[:texture] || :earthmap
    super hash
  end
end
