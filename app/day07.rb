require "colorize"

bags = {}
File.open("../input/day07.txt").each do |line|
  string = " bags contain"
  line.strip!
  color = line[0, line.index(string)].strip
  other_bags = line[(line.index(string) + string.length), (line.length - 3)].strip.split(", ")
  bags[color] = other_bags
end

# Part 1
def can_contain_shiny_gold_bag(bag, bags)
  other_bags = bags[bag]
  return false if other_bags.nil?
  other_bags = other_bags.map { |s| s[s.index(" ") + 1, s.length].gsub(/ bags?.?/, "") }

  if other_bags.include?("shiny gold")
    true
  else
    can_contain = false
    other_bags.each { |other_bag| can_contain |= can_contain_shiny_gold_bag(other_bag, bags)}
    can_contain
  end
end

valid_bags = []
bags.keys.each do |bag|
  valid_bags << bag if can_contain_shiny_gold_bag(bag, bags)
end

puts "Day  7.1: valid bag colors is #{valid_bags.size.to_s.green}"