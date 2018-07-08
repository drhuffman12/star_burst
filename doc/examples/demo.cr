require "./src/star_burst"

puts "ARGV: ##{ARGV}"
width = ARGV.size > 0 ? ARGV[0].to_i : 1000
width = width < 10 ? 10 : width

height = ARGV.size > 1 ? ARGV[1].to_i : 1000
height = height < 10 ? 10 : height

qty_stars = ARGV.size > 2 ? ARGV[2].to_i : 16
qty_stars = qty_stars < 1 ? 1 : qty_stars

qty_ticks = ARGV.size > 3 ? ARGV[3].to_i : 16
qty_ticks = qty_ticks < 1 ? 1 : qty_ticks

radius_delta = ARGV.size > 4 ? ARGV[4].to_f : 10.0
radius_delta = radius_delta < 1.0 ? 1.0 : radius_delta

qty_skies = ARGV.size > 5 ? ARGV[5].to_i : 1
qty_skies = qty_skies < 1 ? 1 : qty_skies

file_path_base = ARGV.size > 6 ? ARGV[6] : "tmp/star_burst"

color_config_path = ARGV.size > 7 ? ARGV[7] : "example/color.config"

puts "width: #{width}"
puts "height: #{height}"
puts "qty_stars: #{qty_stars}"
puts "qty_ticks: #{qty_ticks}"
puts "radius_delta: #{radius_delta}"
puts "qty_skies: #{qty_skies}"
puts "file_path_base: '#{file_path_base}_N_'"

(1..qty_skies).each do |iqs|
  sky = StarBurst::Sky.new(
    width: width,
    height: height,
    qty_stars: qty_stars,
    qty_ticks: qty_ticks,
    radius_delta: radius_delta,
    file_path_base: "#{file_path_base}/sky_#{iqs}",
    color_config_path: color_config_path
  )
  sky.run
end