class Vector
  def **(num)
    Vector[
      self[0] > 0 ? self[0]**num : 0,
      self[1] > 0 ? self[1]**num : 0,
      self[2] > 0 ? self[2]**num : 0
    ]
  end

  def abs
    Vector[
      self[0].abs,
      self[1].abs,
      self[2].abs
    ]
  end

  def directions
    self == Vector[0, 0, 0] ? self : self * (1/(self.magnitude).abs)
  end
end


