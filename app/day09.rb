require "colorize"

numbers = []
File.open("../input/day09.txt").each { |line| numbers << line.to_i }

# Part 1
def find_wrong_one(numbers, preamble)
  current_pos = preamble - 1

  while current_pos < numbers.length
    current_pos += 1
    start_position = current_pos - preamble

    current_number = numbers[current_pos]
    valid_numbers = numbers[start_position, preamble]

    valid = false
    valid_numbers.each do |number|
      valid = true if valid_numbers.include?(current_number - number)
    end

    return current_number unless valid
  end

  return -1
end

wrong_number = find_wrong_one(numbers, 25)
puts "Day  9.1: first wrong one: #{wrong_number.to_s.green}"

# Part 2
def find_set(total, numbers)
  start_pos = 0
  current_pos = 0
  sum = 0

  while sum < total
    sum += numbers[current_pos]
    current_pos += 1

    if sum > total
      start_pos += 1
      current_pos = start_pos
      sum = 0
    end
  end

  numbers[start_pos, current_pos - start_pos]
end

values = find_set(wrong_number, numbers).sort

puts "Day  9.2: result is #{(values.first + values.last).to_s.green}"