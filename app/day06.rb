require "colorize"

answers = []
current_group = ""
File.open("../input/day06.txt").each do |line|
  if line.strip.empty?
    answers << current_group
    current_group = ""
  else
    current_group = "#{current_group}#{line}".strip
  end
end
answers << current_group

# Part 1
def answered_yes_in_group(group)
  count_yes = 0
  for c in 'a'..'z'
    count_yes += 1 if group.include?(c)
  end
  count_yes
end

sum = 0
answers.map{ |a| answered_yes_in_group(a) }.each { |c| sum += c }

puts "Day  6.1: sum is #{sum.to_s.green}"