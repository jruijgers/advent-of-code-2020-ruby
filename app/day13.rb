require "colorize"

file = File.open("../input/day13.txt")
time = file.gets.to_i
bus_times = file.gets.split(",").map { |v| v == "x" ? "x" : v.to_i }
busses = bus_times.reject { |b| b == "x" }

def next_departure(bus, time)
  (1.0 * time / bus).ceil * bus
end

# Part 1
next_departures = busses.map { |b| [b, next_departure(b, time)] }.to_h
next_bus_to_depart = next_departures.sort_by { |_k, v| v }.first
next_bus = next_bus_to_depart[0]
departs_at = next_bus_to_depart[1]

wait_time = departs_at - time

puts "Day 13.1: have to wait for #{wait_time} for bus #{next_bus} (#{(wait_time * next_bus).to_s.green})"

timestamp = 0
step = 1

busses.each do |bus|
  bus_adjustment = bus_times.index(bus)

  while (timestamp + bus_adjustment) % bus != 0
    timestamp += step
  end
  step *= bus
end

puts "Day 13.2: time is #{timestamp.to_s.green}"