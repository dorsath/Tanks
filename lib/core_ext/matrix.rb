class Matrix
  def position_vector
    Vector[
      self[3,0],
      self[3,1],
      self[3,2]
      ]
  end
end
