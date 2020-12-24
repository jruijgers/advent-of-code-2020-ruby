require "colorize"

player1 = []
player2 = []

parsing_player = nil
File.open("../input/day22.txt").each do |line|
  next if line.strip == ""
  if line.include?("Player")
    parsing_player = line.strip
  elsif parsing_player.include?("1")
    player1 << line.strip.to_i
  elsif parsing_player.include?("2")
    player2 << line.strip.to_i
  end
end

while player1.length > 0 && player2.length > 0
  player1card = player1.shift
  player2card = player2.shift

  if player1card > player2card
    player1 += [player1card, player2card]
  else
    player2 += [player2card, player1card]
  end
end

score = 0
cards = player1.size > 0 ? player1 : player2
cards.each_index { |i| score += cards[i] * (cards.length - i)}

puts "Day 22.1: the end score is #{score.to_s.green}"

