require "colorize"
require "./day11/seats"
require "./day11/part1_strategy"
require "./day11/part2_strategy"

seats_origin = []
File.open("../input/day11.txt").each { |l| seats_origin << l.strip }

seats = Day11::Seats.new(seats_origin, Day11::Part1Strategy.new)
next_iteration = seats
begin
  seats = next_iteration
  next_iteration = seats.next_iteration
end while (next_iteration != seats)

puts "Day 11.1: number of occupied seats is #{seats.occupied_seats.to_s.green}"

seats = Day11::Seats.new(seats_origin, Day11::Part2Strategy.new)
next_iteration = seats
begin
  seats = next_iteration
  next_iteration = seats.next_iteration
end while (next_iteration != seats)

puts "Day 11.2: number of occupied seats is #{seats.occupied_seats.to_s.green}"

