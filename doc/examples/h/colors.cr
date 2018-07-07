
def rgba_perc_to_16(pr, pg, pb, pa = 1.0)
  cmax = UInt16::MAX - 1

  cr = (pr * cmax).to_u16
  cg = (pg * cmax).to_u16
  cb = (pb * cmax).to_u16
  ca = (pa * cmax).to_u16

  [cr, cg, cb, ca]
end

  colors = [] of Array(UInt16)

   colors << rgba_perc_to_16(0.784,0.478,0.651)
   colors << rgba_perc_to_16(0.941,0.824,0.89)
   colors << rgba_perc_to_16(0.941,0.8,0.878)
   colors << rgba_perc_to_16(0.514,0.165,0.361)
   colors << rgba_perc_to_16(0.51,0.169,0.361)


   colors << rgba_perc_to_16(0.976,0.922,0.596)
   colors << rgba_perc_to_16(1,0.98,0.875)
   colors << rgba_perc_to_16(1,0.98,0.851)
   colors << rgba_perc_to_16(0.639,0.576,0.204)
   colors << rgba_perc_to_16(0.635,0.573,0.208)

   colors << rgba_perc_to_16(0.376,0.62,0.58)
   colors << rgba_perc_to_16(0.776,0.89,0.871)
   colors << rgba_perc_to_16(0.757,0.89,0.867)
   colors << rgba_perc_to_16(0.129,0.404,0.357)
   colors << rgb0(0.133,0.4,0.357)

puts "colors: #{colors.join { |channels| channels.join(",") + "\n" }}"
