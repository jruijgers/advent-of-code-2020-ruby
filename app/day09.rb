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

puts "Day  09.1: first wrong one: #{find_wrong_one(numbers, 25).to_s.green}"
