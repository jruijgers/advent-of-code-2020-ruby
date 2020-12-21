require "colorize"

class Tile
  attr_reader :id, :data, :neighbours

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

  def top_left_tile?
    return false unless @neighbours.size == 2

    (bottom_edge == @neighbours[0].top_edge && right_edge == @neighbours[1].left_edge) ||
      (bottom_edge == @neighbours[1].top_edge && right_edge == @neighbours[0].left_edge)
  end

  def left_neighbour
    @neighbours.each do |n|
      return n if right_edge == n.left_edge
    end
    nil
  end

  def bottom_neighbour
    @neighbours.each do |n|
      return n if bottom_edge == n.top_edge
    end
    nil
  end

  def find_neighbours(tiles)
    tiles.each do |tile|
      next if tile == self

      if tile.share_edge?(top_edge) ||
        tile.share_edge?(bottom_edge) ||
        tile.share_edge?(left_edge) ||
        tile.share_edge?(right_edge)
        @neighbours << tile
      end
    end
  end

  def share_edge?(other_edge)
    return true if top_edge == other_edge
    return true if top_edge == other_edge.reverse
    return true if bottom_edge == other_edge
    return true if bottom_edge == other_edge.reverse
    return true if left_edge == other_edge
    return true if left_edge == other_edge.reverse
    return true if right_edge == other_edge
    return true if right_edge == other_edge.reverse

    false
  end

  def orient_neighbours
    @neighbours.each do |tile|
      if bottom_edge == tile.top_edge || top_edge == tile.bottom_edge || left_edge == tile.right_edge || right_edge == tile.left_edge
        # do nothing
      elsif bottom_edge == tile.top_edge.reverse || top_edge == tile.bottom_edge.reverse || left_edge == tile.left_edge || right_edge == tile.right_edge
        tile.mirror_vertical
      elsif bottom_edge == tile.bottom_edge || top_edge == tile.top_edge || left_edge == tile.right_edge.reverse || right_edge == tile.left_edge.reverse
        tile.mirror_horizontal
      elsif bottom_edge == tile.bottom_edge.reverse || top_edge == tile.top_edge.reverse || left_edge == tile.left_edge.reverse || right_edge == tile.right_edge.reverse
        tile.mirror_horizontal
        tile.mirror_vertical
      elsif bottom_edge == tile.right_edge || top_edge == tile.left_edge || left_edge == tile.bottom_edge.reverse || right_edge == tile.top_edge.reverse
        tile.turn_left
      elsif bottom_edge == tile.right_edge.reverse || top_edge == tile.left_edge.reverse || left_edge == tile.top_edge.reverse || right_edge == tile.bottom_edge.reverse
        tile.turn_left
        tile.mirror_vertical
      elsif bottom_edge == tile.left_edge || top_edge == tile.right_edge || left_edge == tile.bottom_edge || right_edge == tile.top_edge
        tile.turn_right
        tile.mirror_vertical
      elsif bottom_edge == tile.left_edge.reverse || top_edge == tile.right_edge.reverse || left_edge == tile.top_edge || right_edge == tile.bottom_edge
        tile.turn_right
      end
    end
  end

  def mirror_vertical
    new_data = []
    @data.each { |d| new_data << d.reverse }
    @data = new_data

    @top_edge = nil
    @bottom_edge = nil
    @left_edge = nil
    @right_edge = nil
  end

  def mirror_horizontal
    new_data = []
    @data.reverse.each { |d| new_data << d }
    @data = new_data

    @top_edge = nil
    @bottom_edge = nil
    @left_edge = nil
    @right_edge = nil
  end

  def turn_left
    new_data = []
    (0..@data.length - 1).each do |i|
      new_data[i] = []
      @data.each do |r|
        new_data[i] << r[@data.length - i - 1]
      end
    end
    @data = new_data

    @top_edge = nil
    @bottom_edge = nil
    @left_edge = nil
    @right_edge = nil
  end

  def turn_right
    new_data = []
    (0..@data.length - 1).each do |i|
      new_data[i] = []
      @data.reverse.each do |r|
        new_data[i] << r[i]
      end
    end
    @data = new_data

    @top_edge = nil
    @bottom_edge = nil
    @left_edge = nil
    @right_edge = nil
  end

  def top_edge
    @top_edge ||= @data.first.join
  end

  def bottom_edge
    @bottom_edge ||= @data.last.join
  end

  def left_edge
    @left_edge ||= begin
                     edge = ""
                     @data.each { |d| edge += d.first }
                     edge
                   end
  end

  def right_edge
    @right_edge ||= begin
                      edge = ""
                      @data.each { |d| edge += d.last }
                      edge
                    end
  end

  def ==(other)
    other.class == self.class &&
      other.id == id
  end

  def to_s
    id.to_s
  end

  def data_to_s
    @data.map { |d| d.join }.join("\n")
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
corner_tiles = tiles.select { |t| t.number_of_neighbours == 2 }
corner_tiles.each { |t| product *= t.id }
puts "Day 20.1: product of corner IDs is #{product.to_s.green}"

tiles_to_orient = [corner_tiles.first]
oriented_tiles = []
while tiles_to_orient.length > 0
  tile = tiles_to_orient.shift
  tile.orient_neighbours
  oriented_tiles << tile

  tile.neighbours.reject {|t| oriented_tiles.include?(t) || tiles_to_orient.include?(t) }.each { |n| tiles_to_orient << n }
end

image = []
bottom = tiles.select { |t| t.top_left_tile? }.first
begin
  image_line = image.length
  (0..7).each { |l| image[image_line + l] = [] }
  left = bottom
  begin
    data = left.data
    (0..7).each { |l| image[image_line + l] << data[l + 1][1, 8] }
    left = left.left_neighbour
  end while left
  bottom = bottom.bottom_neighbour
end while bottom

image_tile = Tile.new(0)
image.each { |i| image_tile.add_data_line(i.join) }

# find see monster:
# "                  # "
# "#    ##    ##    ###"
# " #  #  #  #  #  #   "
sea_monster = [[0, 18], [1, 0], [1, 5], [1, 6], [1, 11], [1, 12], [1, 17], [1, 18], [1, 19], [2, 1], [2, 4], [2, 7], [2, 10], [2, 13], [2, 16]]

contains_sea_monsters = false
attempts = 0
begin
  (0..(image_tile.data.length - 3)).each do |x|
    (0..(image_tile.data[0].length - 20)).each do |y|
      contains_sea_monster = true
      sea_monster.each { |sm| contains_sea_monster &= image_tile.data[x + sm[0]][y + sm[1]] == "#" }

      if contains_sea_monster
        contains_sea_monsters = true

        sea_monster.each { |sm| image_tile.data[x + sm[0]][y + sm[1]] = "O" }
      end
    end
  end
  image_tile.turn_right unless contains_sea_monsters
  attempts += 1
end until contains_sea_monsters || attempts >= 4

roughness = 0
image_tile.data.each { |d| roughness += d.select { |d2| d2 == "#" }.length }
puts "Day 20.1: sea roughness is #{roughness.to_s.green}"
