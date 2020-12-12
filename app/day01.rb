require "colorize"

# Part 1
numbers = Array.new
File.open('../input/day01.txt').each { |line| numbers << line.to_i }

found_number = nil
index = 0

while found_number == nil && index < numbers.size
  number = numbers[index]
  matching = 2020 - number

  if numbers.include?(matching)
    found_number = number
  end

  index += 1
end
puts "Day  1.1: found #{found_number} & #{2020 - found_number}. Result = #{(found_number * (2020 - found_number)).to_s.green}"

# Part 2
result = []
numbers.each_index do |x|
  numbers.each_index do |y|
    next if y <= x

    numbers.each_index do |z|
      next if z <= y

      if numbers[x] + numbers[y] + numbers[z] == 2020
        result[0] = numbers[x]
        result[1] = numbers[y]
        result[2] = numbers[z]
      end
    end
  end
end
puts "Day  1.2: found #{result[0]}, #{result[1]}, #{result[2]}. Result = #{(result[0] * result[1] * result[2]).to_s.green}"
