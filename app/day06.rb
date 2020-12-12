require "colorize"

answers = []
current_group = []
File.open("../input/day06.txt").each do |line|
  if line.strip.empty?
    answers << current_group
    current_group = []
  else
    current_group << line.strip
  end
end
answers << current_group

# Part 1
def someone_answered_yes_in_group(group)
  count_yes = 0
  ('a'..'z').each do |c|
    someone_answered_yes = false
    group.each do |individual|
      someone_answered_yes = true if individual.include?(c)
    end
    count_yes += 1 if someone_answered_yes
  end
  count_yes
end

sum = 0
answers.map { |a| someone_answered_yes_in_group(a) }.each { |c| sum += c }

puts "Day  6.1: sum is #{sum.to_s.green}"

# Part 2
def everyone_answered_yes_in_group(group)
  count_yes = 0
  ('a'..'z').each do |c|
    everyone_answered_yes = true
    group.each do |individual|
      everyone_answered_yes = false unless individual.include?(c)
    end
    count_yes += 1 if everyone_answered_yes
  end
  count_yes
end

sum = 0
answers.map { |a| everyone_answered_yes_in_group(a) }.each { |c| sum += c }

puts "Day  6.2: sum is #{sum.to_s.green}"
