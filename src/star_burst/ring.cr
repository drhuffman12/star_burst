# require "stumpy_core"
# require "stumpy_png"
# require "stumpy_gif"
# require "stumpy_utils"

module StarBurst
  class Ring
    # include StumpyPNG
    # include StumpyGIF

    getter logger : Logger

    property star : Star
    property ring_index : Int32

    property wedges = [] of Wedge
    property angle_from, angle_to, radius_from, radius_to

    property cr : UInt16
    property cg : UInt16
    property cb : UInt16
    property ca : UInt16

    property slices : Int32
    property angle_delta : Float64

    def initialize(
      @logger,
      @star,
      @ring_index,
      @radius_from = 0.0, @radius_to = 1.0,
      @cr = UInt16::MAX, @cg = UInt16::MAX, @cb = UInt16::MAX, @ca = UInt16::MAX
      )
      @slices = ((ring_index + 1) * 2 * (radius_to - radius_from)).floor.to_i
      @angle_delta = 2.0 ** ::Math::PI / slices

      logger.debug("INIT: #{self}")
    end

    def tick(canvas)
      logger.debug("TICK (#{self.class.name}): #{self}")
      draw_wedges(canvas)
    end

    def draw(canvas)
      x = star.x
      y = star.y
      color = StumpyCore::RGBA.new(cr, cg, cb, ca)
      canvas.circle(x, y, radius_to, color, false)
      logger.debug("canvas.circle(#{x}, #{y}, #{radius_to}, #{color}, #{false})")
    end
    def draw_wedges(canvas)
      # wedge = StarBurst::Wedge.new(logger, canvas, self)
      drew_any = false
      wedge = StarBurst::Wedge.new(logger, self)
      a_offset = rand # 0.0 # rand
      a_last = 2 * ::Math::PI + a_offset
      a_from = a_offset
      a_to = a_offset
      (0..slices-1).step(2).each do|s|
        a_to = a_from + angle_delta
        next if a_to > a_last

        wedge.move_to(
          angle_from: a_from, angle_to: a_to,
          radius_from: radius_from, radius_to: radius_to,
          cr: cr, cg: cg, cb: cb,
          ca: s % 2 == 0 ? ca : ca / 2
        )
        drew_any ||= wedge.draw(canvas)

        a_from = a_to + angle_delta
      end
      drew_any
    end

    # def draw_wedges(canvas)
    #   wedge = StarBurst::Wedge.new(logger, self)
    #   a_from = 0.0
    #   a_to = 0.0
    #   (0..slices-1).step(2).each do|s|
    #     a_to = a_from + angle_delta
    #     next if a_to > 2 * ::Math::PI

    #     wedge.move_to(
    #       angle_from: a_from, angle_to: a_to,
    #       radius_from: radius_from, radius_to: radius_to,
    #       cr: cr, cg: cg, cb: cb,
    #       ca: s % 2 == 0 ? ca : ca / 2
    #     )
    #     wedge.draw(canvas)

    #     a_from = a_to + angle_delta
    #   end  
    # end
  end
end
