# Part 1
numbers = Array.new
File.open('../input/day-01.txt').each { |line| numbers << line.to_i }

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
puts "Day  1.1: found #{found_number} & #{2020 - found_number}. Result = #{found_number * (2020 - found_number)}"

# Part 2
result = []
numbers.each_index do |x|
  number1 = numbers[x]
  numbers.each_index do |y|
    next if y <= x

    number2 = numbers[y]
    remainder = 2020 - number1 - number2

    numbers.each_index do |z|
      next if z <= y

      number3 = numbers[z]
      if number1 + number2 + number3 == 2020
        result[0] = number1
        result[1] = number2
        result[2] = number3
      end
    end
  end
end
puts "Day  1.2: found #{result[0]}, #{result[1]}, #{result[2]}. Result = #{result[0] * result[1] * result[2]}"
