require "stumpy_core"
require "stumpy_png"
require "stumpy_gif"
require "stumpy_utils"

module StarBurst
  class Wedge
    include StumpyPNG
    include StumpyGIF

    include StarBurst::Math

    getter logger : Logger

    property canvas : Canvas

    property ring : Ring

    property vertices : Array(StumpyCore::Point) # = [] of StumpyCore::Point

    property angle_from : Float64
    property angle_to : Float64
    property radius_from : Float64
    property radius_to : Float64
    
    property cr : UInt16
    property cg : UInt16
    property cb : UInt16
    property ca : UInt16

    def initialize(
      @logger,
      @canvas,
      @ring,
      @angle_from = 0.0,
      @angle_to = 0.5 * ::Math::PI,
      @radius_from = 1.0, @radius_to = 2.0,
      @cr = UInt16::MAX, @cg = UInt16::MAX, @cb = UInt16::MAX, @ca = UInt16::MAX
      )
      @vertices = [] of StumpyCore::Point

      logger.debug("INIT: #{self}")
    end

    def move_to(
      angle_from = 0.0,
      angle_to = 0.5 * ::Math::PI,
      radius_from = 1.0, radius_to = 2.0,
      cr = UInt16::MAX, cg = UInt16::MAX, cb = UInt16::MAX, ca = UInt16::MAX
      )
      @angle_from = angle_from
      @angle_to = angle_to
      @radius_from = radius_from
      @radius_to = radius_to
      @cr = cr
      @cg = cg
      @cb = cb
      @ca = ca

      @vertices = [] of StumpyCore::Point
      add_vertices
    end

    def is_offscreen(canvas, vertex)
      vertex.x < 0.0 || vertex.x > canvas.width ||
        vertex.y < 0.0 || vertex.y > canvas.height
    end

    def goes_offscreen(canvas)
      is_offscreen(canvas, vertices[0]) || is_offscreen(canvas, vertices[1])
    end

    def other_stars
      (ring.star.sky.stars - [ring.star])
    end

    def vertex_overlaps_other_star(canvas, other_star, vertex)
      overlaps = false

      vx = vertex.x
      vy = vertex.y
      sx = other_star.x
      sy = other_star.y

      dx = sx - vx
      dy = sy - vy

      dist = ::Math.sqrt(dx * dx + dy * dy)
      other_star_radius = other_star.radius_max
      overlaps = dist < other_star_radius

      # debug_overlap(canvas, other_star, vertex, dist, vx, vy, sx, sy, other_star_radius) if overlaps

      overlaps
    end

    def debug_overlap(canvas, other_star, vertex, dist, vx, vy, sx, sy, other_star_radius)
      cx = ring.star.x
      cy = ring.star.y

      canvas_diag_dist = ::Math.sqrt(canvas.width ** 2 + canvas.height ** 2)
      relative_dist = dist / canvas_diag_dist
      gray_scale = (relative_dist * (UInt16::MAX - 1)).to_u16

      color = StumpyCore::RGBA.new(gray_scale, gray_scale, gray_scale, UInt16::MAX / 10)

      logger.debug("vertex_overlaps_other_star(..) -> c: #{[ring.star.star_index, cx,cy, 360 * angle_from / (2 * ::Math::PI), radius_from, radius_to]}, v: #{[vx,vy]}, s: #{[other_star.star_index, sx,sy]}, dist: #{dist}, radius_from: #{radius_from}, other_star_radius: #{other_star_radius}, relative_dist: #{relative_dist}")
      
      canvas.line(vx, vy, sx, sy, color)
    end

    def overlaps_any_other_stars(canvas)
      overlaps = false
      other_stars.each do |other_star|
        overlaps = vertex_overlaps_other_star(canvas, other_star, vertices[0]) || vertex_overlaps_other_star(canvas, other_star, vertices[1])
        break if overlaps
      end
      overlaps
    end

    def draw(canvas)
      return if goes_offscreen(canvas) || overlaps_any_other_stars(canvas)

      x = ring.star.x
      y = ring.star.y
      color = StumpyCore::RGBA.new(cr, cg, cb, ca)
      # canvas.fill_polygon(vertices, color)
      draw_side(canvas, 0, 1, color)
    end

    def draw_side(canvas, i_vertex_from, i_vertex_to, color)
      x0 = vertices[i_vertex_from].x
      y0 = vertices[i_vertex_from].y
      x1 = vertices[i_vertex_to].x
      y1 = vertices[i_vertex_to].y
      canvas.line(x0, y0, x1, y1, color)
    end

    def add_vertices
      x = ring.star.x
      y = ring.star.y

      @vertices = [] of StumpyCore::Point

      ## First two vertices to just draw a line for the wedge
      p = radial_point(x, y, angle_from, radius_from)
      vertices << StumpyCore::Point.new(p[:x], p[:y])

      p = radial_point(x, y, angle_from, radius_to)
      @vertices << StumpyCore::Point.new(p[:x], p[:y])

      ## Un-comment below to draw the whole wedge (and switch 'canvas.line' to 'canvas.fill_polygon' in '#draw')
      # p = radial_point(x, y, angle_to, radius_to)
      # @vertices << StumpyCore::Point.new(p[:x], p[:y])

      # p = radial_point(x, y, angle_to, radius_from)
      # @vertices << StumpyCore::Point.new(p[:x], p[:y])

      # p = radial_point(x, y, angle_from, radius_from)
      # @vertices << StumpyCore::Point.new(p[:x], p[:y])

      logger.debug("vertices #{vertices}")

      vertices
    end
  end
end
