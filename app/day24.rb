require "colorize"

input_file = "../input/day24.txt"
# input_file = "../input/day24-example.txt"

tile_directions = []
File.open(input_file).each { |l| tile_directions << l.strip }

class Tile
  attr_reader :color

  def initialize
    @color = "W"
  end

  def black?
    @color == "B"
  end

  def white?
    @color == "W"
  end

  def flip
    @color = @color == "W" ? "B" : "W"
  end

  def to_s
    "[#{@color}]"
  end
end

tiles = {}

tile_directions.each do |t|
  x = 0
  y = 0
  directions = t.split("")
  while directions.length > 0
    direction = directions.shift
    direction += directions.shift if direction == "n" || direction == "s"

    case direction
    when "e"
      x += 1
    when "w"
      x -= 1
    when "se"
      y += 1
    when "nw"
      y -= 1
    when "sw"
      x -= 1
      y += 1
    when "ne"
      x += 1
      y -= 1
    end
  end
  tile = tiles[[x, y]] || Tile.new
  tiles[[x, y]] = tile
  tile.flip
end

count_black_tiles = tiles.select { |_k, v| v.black? }.count
puts "Day 24.1: there are #{count_black_tiles.to_s.green} black tiles"

rounds = 0
while rounds < 100
  rounds += 1

  min_x = 0
  max_x = 0
  min_y = 0
  max_y = 0
  tiles.keys.each do |k|
    min_x = k[0] if k[0] < min_x
    max_x = k[0] if k[0] > max_x
    min_y = k[1] if k[1] < min_y
    max_y = k[1] if k[1] > max_y
  end

  tiles_to_flip = {}
  ((min_x-1)..(max_x+1)).each do |x|
    ((min_y-1)..(max_y+1)).each do |y|
      count_black_tiles = 0
      count_black_tiles += 1 if tiles[[x + 1, y]]&.black?
      count_black_tiles += 1 if tiles[[x - 1, y]]&.black?
      count_black_tiles += 1 if tiles[[x, y + 1]]&.black?
      count_black_tiles += 1 if tiles[[x, y - 1]]&.black?
      count_black_tiles += 1 if tiles[[x - 1, y + 1]]&.black?
      count_black_tiles += 1 if tiles[[x + 1, y - 1]]&.black?

      tile = tiles[[x, y]] || Tile.new
      tiles_to_flip[[x, y]] = tile if tile.black? && count_black_tiles != 1
      tiles_to_flip[[x, y]] = tile if tile.white? && count_black_tiles == 2
    end
  end

  tiles_to_flip.each do |location, tile|
    tile.flip

    tiles[location] = tile
  end
end

puts "Day 24.2: after 100 days there are #{tiles.select {|_k, v| v.black? }.count.to_s.green} black tiles"