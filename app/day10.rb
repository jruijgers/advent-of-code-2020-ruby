require "colorize"

all_adapters = []
File.open("../input/day10.txt").each { |line| all_adapters << line.to_i }
all_adapters.sort!

diff_one = 1
diff_three = 1

all_adapters.each_index do |index|
  next if index == 0

  difference = all_adapters[index] - all_adapters[index - 1]
  if difference == 1
    diff_one += 1
  elsif difference == 3
    diff_three += 1
  end
end

puts "Day 10.1: result is #{(diff_one * diff_three).to_s.green}"

valid_configurations = {}

def valid_difference(adapter1, adapter2)
  return false if adapter1.nil? || adapter2.nil?

  adapter2 - adapter1 <= 3
end

def find_configurations(current_pos, current_configuration, adapters, valid_configurations)
  if valid_configurations.has_key?(current_pos)
    return valid_configurations[current_pos]
  end

  if current_pos == adapters.length - 1
    valid_configurations[current_pos] = 1
  else
    configs = 0
    configs += find_configurations(current_pos + 1, current_configuration.dup, adapters, valid_configurations)
    configs += find_configurations(current_pos + 2, current_configuration.dup, adapters, valid_configurations) if valid_difference(adapters[current_pos], adapters[current_pos + 2])
    configs += find_configurations(current_pos + 3, current_configuration.dup, adapters, valid_configurations) if valid_difference(adapters[current_pos], adapters[current_pos + 3])
    valid_configurations[current_pos] = configs

    configs
  end
end

result = find_configurations(-1, [], all_adapters, valid_configurations)
puts "Day 10.2: result is #{result.to_s.green}"
