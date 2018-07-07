# require "stumpy_core"
# require "stumpy_png"
# require "stumpy_gif"
# require "stumpy_utils"

module StarBurst
  class Star
    getter logger : Logger

    property sky : Sky
    property star_index : Int32
    property ring_index : Int32

    property x, y

    property radius_delta
    property radius_prev
    property radius_max
    property cr : UInt16
    property cg : UInt16
    property cb : UInt16
    property ca : UInt16

    def initialize(
      @logger,
      @sky,
      @star_index = -1,
      @x = 0, @y = 0,
      @radius_delta = 10.0,
      @cr = UInt16::MAX, @cg = UInt16::MAX, @cb = UInt16::MAX, @ca = UInt16::MAX
      )
      @radius_prev = 0.0
      @radius_max = 0.0
      @ring_index = 0

      logger.debug("INIT: #{self}, star_index: #{star_index}, x: #{x}, y: #{y}")
    end

    def tick(canvas, cr, cg, cb, ca)
      logger.debug("TICK (#{self.class.name}): #{self}")
      
      @cr = cr
      @cg = cg
      @cb = cb
      @ca = ca

      @radius_prev = @radius_max
      @radius_max += radius_delta
      add_ring.tick(canvas)
    end

    def add_ring
      @ring_index += 1
      StarBurst::Ring.new(
        logger,
        self,
        ring_index: ring_index, radius_from: radius_prev, radius_to: radius_max,
        cr: cr,
        cg: cg,
        cb: cb, 
        ca: ca
      )
    end
  end
end
