require "colorize"
require "./day08/program"
require "./day08/instruction"

program = Day08::Program.new
File.open("../input/day08.txt").each do |line|
  line.strip!
  parts = line.split(" ")
  program.add_instruction(Day08::Instruction.new(parts[0], parts[1].to_i))
end

# Part 1
program.execute
puts "Day  8.1: accumulator is #{program.accumulator.to_s.green}"

# Part 2
result = nil
instruction_counter = 0
until result
  instruction = program.instructions[instruction_counter]
  instruction_counter += 1

  next if instruction.type == "acc"

  instruction.update

  if program.execute
    result = program.accumulator
  else
    instruction.update
  end
end

puts "Day  8.2: updated accumulator is #{result.to_s.green}"