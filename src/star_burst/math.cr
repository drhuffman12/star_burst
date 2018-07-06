module StarBurst
  module Math
    def radial_point(x, y, angle, radius)
      dx = ::Math.sin(angle) * radius
      dy = ::Math.cos(angle) * radius
      {x: x + dx, y: y - dy}
    end
  end
end
