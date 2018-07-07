require "logger"
require "stumpy_core"
# require "stumpy_png"
require "stumpy_gif"
require "stumpy_utils"

module StarBurst
  class Sky
    CHANCE_OF_NEW_STAR = 0.5
    # include StumpyPNG
    include StumpyGIF

    property frames = [] of Canvas

    property stars : Array(Star)
    property width, height
    property qty_stars : Int32, qty_ticks : Int32
    property radius_delta
    property file_path_base
    property color_config_path
    property color_palette
    property ticks : Int64

    getter logger : Logger
    getter log_file

    def initialize(@width = 100, @height = 100,
        @qty_stars = 3, @qty_ticks = 4,
        @radius_delta = 10.0,
        @file_path_base = "tmp/star_burst",
        @color_config_path = ""
      )
      @stars = [] of Star
      @ticks = 0

      @log_file = File.new(filename = "tmp/log.txt", mode = "w")
      @logger = Logger.new(log_file)
      logger.level = Logger::WARN

      @color_palette = Array(Array(UInt16)).new

      logger.debug("INIT: #{self}")
    end

    def seed_initial_stars(qty : Int32)
      (1..qty).each do |q|
        seed_star
        # @stars << Star.new(
        #   logger,
        #   star_index: q,
        #   sky: self,
        #   radius_delta: radius_delta,
        #   x: rand(width),
        #   y: rand(height)
        # )
      end
    end

    def seed_star
      @stars << Star.new(
        logger,
        star_index: stars.size + 1,
        sky: self,
        radius_delta: radius_delta,
        x: rand(width),
        y: rand(height)
      )
    end

    def run
      load_color_config

      canvas_blank = Canvas.new(width, height, RGBA::WHITE)
      @frames << canvas_blank

      canvas = Canvas.new(width, height, RGBA::WHITE)

      seed_initial_stars(qty_stars)

      (1..qty_ticks).each do |t|
        logger.debug("TICK #: #{t}")
        # tick(canvas)
        any_star_can_draw_another_ring = tick(canvas)
        
        break unless any_star_can_draw_another_ring
        
        canvas2 = Canvas.new(width, height) { |x, y| canvas.get(x,y) }
        canvas = canvas2
        @ticks += 1
      end

      save_anim
    end

    def load_color_config
      if color_config_path > "" && File.file?(color_config_path) && File.size(color_config_path) > 0
        color_config_str = File.read(color_config_path)
        @color_palette = color_config_str.lines.map { |line| line.split(",").map { |channel| channel.strip.to_u16 } }

        puts "color_palette: #{color_palette}"
        puts
      end
    end

    def save_color_config
      if color_config_path > ""
        File.write(color_config_path, color_palette.join { |channels| channels.join(",") + "\n" })
      end
    end

    def save_color_config_from_percents
      # color_config_path = "tmp/color.config"
      if color_config_path > ""
        color_percents = [
          [1, 0, 0, 1],
          [0, 1, 0, 1],
          [0, 0, 1, 1],
        ]
        color_config_values = color_percents.map do |channels|
          channels.map do |c|
            c16 = (c * UInt16::MAX - 1).to_u16
            case
            when c16 < 0
              0
            when c16 >= UInt16::MAX
              UInt16::MAX - 1
            else
              c16
            end
          end
        end

        color_config_str = color_config_values.join { |channels| channels.join(",") + "\n" }

        File.write(color_config_path, color_config_str)
      end
    end

    def rnd_color_set
      if color_config_path > ""
        i = rand(color_palette.size)
        cr, cg, cb, ca = color_palette[i]
        [cr, cg, cb, ca]
      else
        cr = rand(UInt16::MAX).to_u16
        cg = rand(UInt16::MAX).to_u16
        cb = rand(UInt16::MAX).to_u16
        ca = (UInt16::MAX / 2).to_u16
        [cr, cg, cb, ca]
      end
    end


    # def tick(canvas)
    #   # cr = rand(UInt16::MAX).to_u16
    #   # cg = rand(UInt16::MAX).to_u16
    #   # cb = rand(UInt16::MAX).to_u16
    #   # ca = (UInt16::MAX / 2).to_u16
    #   cr, cg, cb, ca = rnd_color_set

    #   stars.each { |star| star.tick(canvas, cr, cg, cb, ca) }

    #   save_frame(canvas)
    #   @frames << canvas
    # end
    def tick(canvas)
      # cr = rand(UInt16::MAX).to_u16
      # cg = rand(UInt16::MAX).to_u16
      # cb = rand(UInt16::MAX).to_u16
      # ca = (UInt16::MAX / 2).to_u16
      cr, cg, cb, ca = rnd_color_set
     
      seed_star if rand < CHANCE_OF_NEW_STAR

      # stars.each { |star| star.tick(canvas, cr, cg, cb, ca) }
      any_star_can_draw_another_ring = stars.map do |star|
        star.tick(canvas, cr, cg, cb, ca)
      end.any?

      save_frame(canvas)
      @frames << canvas

      any_star_can_draw_another_ring
    end

    def save_frame(canvas)
      dir_path = File.expand_path(file_path_base + "/frames")
      file_path = dir_path + "/frame_" + @ticks.to_s

      # puts "dir_path: #{dir_path}, file_path: #{file_path}"
      print "."

      Dir.mkdir_p(dir_path) unless File.exists?(dir_path) && File.directory?(dir_path)

      # StumpyPNG.write(canvas, file_path + ".png")
      StumpyGIF.write([canvas], file_path + ".gif")

      {file_path: file_path, qty_stars: stars.size}
    end

    def save_anim
      dir_path = File.expand_path(file_path_base)
      file_path = dir_path + "/frames.gif"
      
      puts
      puts "Saving anim to file_path: #{file_path}"
      Dir.mkdir_p(dir_path) unless File.exists?(dir_path) && File.directory?(dir_path)

      StumpyGIF.write(frames, file_path)
      puts
    end
  end
end
