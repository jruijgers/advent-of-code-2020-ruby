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

player1cards = player1.dup
player2cards = player2.dup
while player1cards.length > 0 && player2cards.length > 0
  player1card = player1cards.shift
  player2card = player2cards.shift

  if player1card > player2card
    player1cards += [player1card, player2card]
  else
    player2cards += [player2card, player1card]
  end
end

score = 0
(winner, cards) = player1cards.size > 0 ? [1, player1cards] : [2, player2cards]
cards.each_index { |i| score += cards[i] * (cards.length - i) }

puts "Day 22.2: player #{winner.to_s.green} wins Combat with a score of #{score.to_s.green}"

class RecursiveCombat
  def initialize(player1, player2, level = 0)
    @player1 = player1
    @player2 = player2
    @level = level

    @previous_rounds = []
  end

  def play
    round = 0
    while @player1.length > 0 && @player2.length > 0
      if @previous_rounds.include?([@player1.hash, @player2.hash].hash)
        return [1, @player1]
      else
        @previous_rounds << [@player1.hash, @player2.hash].hash
      end

      round += 1

      player1card = @player1.shift
      player2card = @player2.shift

      if player1card <= @player1.length && player2card <= @player2.length
        player1cards = @player1.first(player1card)
        player2cards = @player2.first(player2card)

        (winner, _cards) = RecursiveCombat.new(player1cards, player2cards, @level + 1).play

        if winner == 1
          @player1 += [player1card, player2card]
        else
          @player2 += [player2card, player1card]
        end
      else
        if player1card > player2card
          @player1 += [player1card, player2card]
        else
          @player2 += [player2card, player1card]
        end
      end
    end

    if @player1.length > 1
      [1, @player1]
    else
      [2, @player2]
    end
  end
end

(winner, cards) = RecursiveCombat.new(player1.dup, player2.dup).play
score = 0
cards.each_index { |i| score += cards[i] * (cards.length - i) }

puts "Day 22.2: player #{winner.to_s.green} wins RecursiveCombat with a score of #{score.to_s.green}"
