require "colorize"
require "./program/program"
require "./program/instruction"

program = Program::Program.new
File.open("../input/day08.txt").each do |line|
  line.strip!
  parts = line.split(" ")
  program.add_instruction(Program::Instruction.new(parts[0], parts[1].to_i))
end

# Part 1
puts "Day  8.1: accumulator is #{program.execute.to_s.green}"