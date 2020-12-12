require "colorize"

hill = []
File.open('../input/day-03.txt').each { |line| hill << line.strip }

def tree_hits(hill, pos_increase, line_increase = 1)
  pos = 0
  line = 0
  trees = 0
  while line < hill.length
    hill_line = hill[line]
    trees += 1 if hill_line[pos % hill_line.length] == "#"
    pos += pos_increase
    line += line_increase
  end

  trees
end

# Part 1
trees = tree_hits(hill, 3)
puts "Day  3.1: hit #{trees.to_s.green}"

# part 1
trees1 = tree_hits(hill, 1)
trees3 = tree_hits(hill, 5)
trees4 = tree_hits(hill, 7)
trees5 = tree_hits(hill, 1, 2)

product = trees * trees1 * trees3 * trees4 * trees5
puts "Day  3.2: product #{product.to_s.green}"