require "colorize"

class Tile
  attr_reader :id

  def initialize(id)
    @id = id
    @data = []
    @neighbours = []
  end

  def add_data_line(line)
    @data << line.split("")
  end

  def number_of_neighbours
    @neighbours.length
  end

  def find_neighbours(tiles)
    tiles.each do |tile|
      next if tile == self

      if tile.share_edge?(@data.first.join) ||
        tile.share_edge?(@data.last.join) ||
        tile.share_edge?(left_edge) ||
        tile.share_edge?(right_edge)
        @neighbours << tile
      end
    end
  end

  def share_edge?(other_edge)
    return true if @data.first.join == other_edge
    return true if @data.first.join == other_edge.reverse
    return true if @data.last.join == other_edge
    return true if @data.last.join == other_edge.reverse
    return true if left_edge == other_edge
    return true if left_edge == other_edge.reverse
    return true if right_edge == other_edge
    return true if right_edge == other_edge.reverse

    false
  end

  private

  def left_edge
    edge = ""
    @data.each { |d| edge += d.first }
    edge
  end

  def right_edge
    edge = ""
    @data.each { |d| edge += d.last }
    edge
  end
end

tiles = []
current_tile = nil
File.open("../input/day20.txt").each do |line|
  next if line.strip == ""

  if line.match(/Tile (\d+):/)
    current_tile = Tile.new(line.match(/Tile (\d+):/)[1].to_i)
    tiles << current_tile
  else
    current_tile.add_data_line(line.strip)
  end
end

tiles.each do |tile|
  tile.find_neighbours(tiles)
end

product = 1
tiles.select { |t| t.number_of_neighbours == 2 }.each { |t| product *= t.id }
puts "Day 20.1: product of corner IDs is #{product.to_s.green}"