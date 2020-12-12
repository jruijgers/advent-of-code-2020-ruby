require "colorize"

hill = []
File.open('../input/day-03.txt').each { |line| hill << line.strip }

# Part 1
pos = 0
trees = 0
hill.each do |line|
  trees += 1 if line[pos % line.length] == "#"
  pos += 3
end

puts "Day  3.1: hit #{trees.to_s.green}"