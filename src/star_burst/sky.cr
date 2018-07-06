require "logger"
require "stumpy_core"
require "stumpy_png"
require "stumpy_gif"
require "stumpy_utils"

module StarBurst
  class Sky
    include StumpyPNG
    include StumpyGIF

    property frames = [] of Canvas

    property stars : Array(Star)
    property width, height
    property qty_stars : Int32, qty_ticks : Int32
    property radius_delta
    property file_path_base
    property ticks : Int64

    getter logger : Logger
    getter log_file

    def initialize(@width = 100, @height = 100,
        @qty_stars = 3, @qty_ticks = 4,
        @radius_delta = 10.0,
        @file_path_base = "tmp/star_burst"
      )
      @stars = [] of Star
      @ticks = 0

      @log_file = File.new(filename = "tmp/log.txt", mode = "w")
      @logger = Logger.new(log_file)
      logger.level = Logger::WARN

      logger.debug("INIT: #{self}")
    end

    def seed_stars(qty : Int32)
      (1..qty).each do |q|
        @stars << Star.new(
          logger,
          star_index: q,
          sky: self,
          radius_delta: radius_delta,
          x: rand(width),
          y: rand(height)
        )
      end
    end

    def run
      canvas_blank = Canvas.new(width, height, RGBA::WHITE)
      @frames << canvas_blank

      canvas = Canvas.new(width, height, RGBA::WHITE)

      seed_stars(qty_stars)

      (1..qty_ticks).each do |t|
        logger.debug("TICK #: #{t}")
        tick(canvas)
        
        canvas2 = Canvas.new(width, height) { |x, y| canvas.get(x,y) }
        canvas = canvas2
        @ticks += 1
      end

      save_frames
    end

    def tick(canvas)
      cr = rand(UInt16::MAX).to_u16
      cg = rand(UInt16::MAX).to_u16
      cb = rand(UInt16::MAX).to_u16
      ca = (UInt16::MAX / 2).to_u16

      stars.each { |star| star.tick(canvas, cr, cg, cb, ca) }

      save_frame(canvas)
      @frames << canvas
    end

    def save_frame(canvas)
      file_path = file_path_base + @ticks.to_s
      StumpyPNG.write(canvas, file_path + ".png")
      StumpyGIF.write([canvas], file_path + ".gif")

      {file_path: file_path, qty_stars: stars.size}
    end

    def save_frames
      StumpyGIF.write(frames, file_path_base + ".gif")
    end
  end
end
