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

# Part 2
def how_many_bags(bag, bags)
  other_bags = bags[bag]

  if other_bags.include?("no other bags.")
    0
  else
    total = 0
    other_bags.each do |other_bag|
      number = other_bag[0, other_bag.index(" ")].to_i
      total += number

      other_bag_color = other_bag[other_bag.index(" ") + 1, other_bag.length].gsub(/ bags?.?/, "")
      total += number * how_many_bags(other_bag_color, bags)
    end
    total
  end
end

number_of_bags = how_many_bags("shiny gold", bags)
puts "Day  7.2: number of bags inside mine is #{number_of_bags.to_s.green}"
