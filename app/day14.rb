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

  def apply_to_memory_address(address)
    address_mask = ""
    address_bit = address.to_s(2)
    address_bit = "0" * (36 - address_bit.length) + address_bit
    (0..35).each do |pos|
      if @mask[pos] == '0'
        address_mask << address_bit[pos]
      else
        address_mask << @mask[pos]
      end
    end

    memory_addresses(address_mask.dup)
  end

  def to_s
    "#{@mask} : #{@and_mask.to_s(2)} : #{@or_mask.to_s(2)}"
  end

  def memory_addresses(address_mask)
    if address_mask.count("X") == 0
      [address_mask]
    else
      pos = address_mask.index("X")
      addresses = []
      address_mask[pos] = "0"
      addresses += memory_addresses(address_mask.dup)
      address_mask[pos] = "1"
      addresses += memory_addresses(address_mask.dup)
      addresses
    end
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

# Part 1
memory = {}
mask = Mask.new("X" * 36)
lines.each do |l|
  parts = l.split(" = ")
  if parts[0] == "mask"
    mask = Mask.new(parts[1].strip)
  else
    index = parts[0].gsub("mem[", "").gsub("]", "").to_i
    value = parts[1].to_i
    memory_addresses = mask.apply_to_memory_address(index)

    memory_addresses.each do |address|
      memory[address.to_i(2)] = value
    end
  end
end

sum = 0
memory.values.each do |value|
  sum += value
end

puts "Day 14.2: sum in memory is #{sum.to_s.green}"
