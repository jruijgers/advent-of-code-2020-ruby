require "colorize"

input = "459672813"
# input = "389125467" # @example

def parse(input)
  first_number = input[0].to_i
  last_number = first_number
  game = []
  input.split("").map do |n|
    next if n.to_i == last_number
    game[last_number] = n.to_i
    last_number = n.to_i
  end
  game[last_number] = first_number
  [game, first_number]
end

def print_game(game, start_number)
  current_number = start_number
  result = ""
  begin
    result += "#{current_number} "
    current_number = game[current_number]
  end while game[current_number] != start_number
  result
end

def play_for_rounds(game, first_number, rounds, max_value)
  current_number = first_number
  while rounds > 0
    next_3 = [game[current_number]]
    next_3 << game[next_3.last]
    next_3 << game[next_3.last]

    number = current_number
    begin
      number -= 1
      number = max_value if number < 1
    end while next_3.include?(number)

    # puts print_game(game, current_number)
    # puts current_number
    # puts next_3.join(",")
    # puts number
    # puts
    game[current_number] = game[next_3.last]
    game[next_3.last] = game[number]
    game[number] = next_3.first

    current_number = game[current_number]
    rounds -= 1
  end
end

(game, first_number) = parse(input)
play_for_rounds(game, first_number, 100, 9)

result = ""
current_number = game[1]
while current_number != 1
  result += current_number.to_s
  current_number = game[current_number]
end

puts "Day 23.1: end result: #{result.green}"

(game, first_number) = parse(input)
last_number = input.split("").last.to_i
(10..1_000_000).each do |n|
  game[n.to_i] = game[last_number]
  game[last_number] = n.to_i
  last_number = n.to_i
end
play_for_rounds(game, first_number, 10_000_000, 1_000_000)

first_number = game[1]
second_number = game[game[1]]
puts "Day 23.2: end result: #{(first_number * second_number).to_s.green}"
