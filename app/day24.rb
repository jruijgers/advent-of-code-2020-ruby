require "colorize"

input_file = "../input/day24.txt"

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

  def flip
    @color = @color == "W" ? "B" : "W"
  end

  def to_s
    "[#{@color}]"
  end
end

tiles = Hash.new { |hash, key| hash[key] = Tile.new }

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
  tile = tiles[[x, y]]
  tile.flip
end

count_black_tiles = tiles.select { |_k, v| v.black? }.count
puts "Day 24.1: there are #{count_black_tiles.to_s.green} black tiles"

