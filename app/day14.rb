require "colorize"

lines = []
File.open("../input/day14.txt").each { |l| lines << l.strip }

class Mask
  def initialize(mask)
    @mask = mask
    @and_mask = 0
    @or_mask = 0

    mask.split('').each do |c|
      @and_mask = @and_mask << 1
      @or_mask = @or_mask << 1

      if c == '1'
        @and_mask = @and_mask | 1
        @or_mask = @or_mask | 1
      elsif c == 'X'
        @and_mask = @and_mask | 1
      end
    end
  end

  def apply_to_value(number)
    number & @and_mask | @or_mask
  end

  def to_s
    "#{@mask} : #{@and_mask.to_s(2)} : #{@or_mask.to_s(2)}"
  end
end

# Part 1
memory = []
mask = Mask.new("X" * 36)
lines.each do |l|
  parts = l.split(" = ")
  if parts[0] == "mask"
    mask = Mask.new(parts[1].strip)
  else
    index = parts[0].gsub("mem[", "").gsub("]", "").to_i
    memory[index] = mask.apply_to_value(parts[1].to_i)
  end
end

sum = 0
memory.each do |value|
  sum += value unless value.nil?
end

puts "Day 14.1: sum in memory is #{sum.to_s.green}"