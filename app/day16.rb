require "colorize"
require "./day16/ticket"
require "./day16/rule"

rules = []
my_ticket = []
nearby_tickets = []
scanning = "rules"
File.open("../input/day16.txt").each do |line|
  next if line.strip.empty?

  if line.include?("ticket")
    scanning = line.strip
  elsif scanning == "rules"
    rules << Day16::Rule.parse(line)
  elsif scanning.include?("tickets")
    nearby_tickets << Day16::Ticket.new(line)
  else
    my_ticket = Day16::Ticket.new(line)
  end
end

invalid_tickets = nearby_tickets.reject { |t| t.valid?(rules) }
invalid_ticket_values = invalid_tickets.map { |t| t.invalid_values(rules) }.flatten

sum = 0
invalid_ticket_values.each { |v| sum += v }

puts "Day 16.1: sum of invalid tickets values is #{sum.to_s.green}"

valid_tickets = nearby_tickets.select { |t| t.valid?(rules) }
valid_positions = []
(1..rules.length).each { |_i| valid_positions << rules.dup }

valid_tickets.each do |ticket|
  valid_positions.each_index do |index|
    valid_positions[index] = ticket.valid_rules(index, valid_positions[index])
  end
end

while valid_positions.select { |r| r.length > 1 }.length > 0
  valid_positions.select { |r| r.length == 1 }.each do |rules|
    valid_positions.each_index do |i|
      next if valid_positions[i].length == 1

      valid_positions[i] -= rules
    end
  end
end

result = 1
rule_positions = valid_positions.flatten
rule_positions.each_index do |index|
  next unless rule_positions[index].name.include?("departure")

  result *= my_ticket.value(index)
end

puts "Day 16.2: product of departure values is #{result.to_s.green}"
