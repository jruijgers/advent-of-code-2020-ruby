require "colorize"
require "./day18/operation"
require "./day18/simple_operation"

lines = []
File.open("../input/day18.txt").each { |l| lines << l.strip }
# lines << "1 + 2 * 3 + 4 * 5 + 6" # 71
# lines << "1 + (2 * 3) + (4 * (5 + 6))" # 51
# lines << "2 * 3 + (4 * 5)" # 26
# lines << "5 + (8 * 3 + 9 + 3 * 4 * 3)" # 437
# lines << "5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))" # 12240
# lines << "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2" # 13632

sum = 0
lines.each do |line|
  operation = Day18::SimpleOperation.parse(line)
  sum += operation.calculate
end

puts "Day 18.1: sum of homework is #{sum.to_s.green}"
