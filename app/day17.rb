require "colorize"
require "./day17/conway_cubes_power_cube"
require "./day17/conway_hyper_power_cube"

lines = []
File.open("../input/day17.txt").each { |l| lines << l.strip }

power_grid = Day17::ConwayCubesPowerGrid.parse(lines)
power_grid.power_up

puts "Day 17.1: Cubed power grid #{power_grid.active_cells.to_s.green} active cells"

power_grid = Day17::ConwayHyperPowerGrid.parse(lines)
power_grid.power_up

puts "Day 17.1: Hyper power grid #{power_grid.active_cells.to_s.green} active cells"

