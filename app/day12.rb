require "colorize"

directions = []
File.open("../input/day12.txt").each { |l| directions << l.strip }

wind_directions = ["N", "E", "S", "W"]
current_direction = "E"
north_south = 0
east_west = 0

directions.each do |direction|
  i = direction[0]
  amount = direction[1, direction.length].to_i
  if i == "N" || (i == "F" && current_direction == "N")
    north_south += amount
  elsif i == "S" || (i == "F" && current_direction == "S")
    north_south -= amount
  elsif i == "E" || (i == "F" && current_direction == "E")
    east_west += amount
  elsif i == "W" || (i == "F" && current_direction == "W")
    east_west -= amount
  elsif i == "R" || i == "L"
    index = wind_directions.index(current_direction)

    if i == "R" && amount == 90
      index += 1
    elsif i == "R" && amount == 180
      index += 2
    elsif i == "R" && amount == 270
      index += 3
      elsif i == "L" && amount == 90
      index -= 1
    elsif i == "L" && amount == 180
      index -= 2
    elsif i == "L" && amount == 270
      index -= 3
    end

    current_direction = wind_directions[index % 4]
  end
end

puts "Day 12.1: manhattan distance is #{(north_south.abs + east_west.abs).to_s.green}"

north_south = 0
east_west = 0
waypoint_north_south = 1
waypoint_east_west = 10

directions.each do |direction|
  i = direction[0]
  amount = direction[1, direction.length].to_i
  if i == "N"
    waypoint_north_south += amount
  elsif i == "S"
    waypoint_north_south -= amount
  elsif i == "E"
    waypoint_east_west += amount
  elsif i == "W"
    waypoint_east_west -= amount
  elsif i == "F"
    north_south += waypoint_north_south * amount
    east_west += waypoint_east_west * amount
  elsif i == "R"
    while amount > 0
      temp = waypoint_north_south
      waypoint_north_south = -waypoint_east_west
      waypoint_east_west = temp
      amount -= 90
    end
  elsif i == "L"
    while amount > 0
      temp = waypoint_north_south
      waypoint_north_south = waypoint_east_west
      waypoint_east_west = -temp
      amount -= 90
    end
  end
end

puts "Day 12.1: manhattan distance is #{(north_south.abs + east_west.abs).to_s.green}"
