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