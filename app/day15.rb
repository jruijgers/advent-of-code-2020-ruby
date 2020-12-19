require "colorize"

start_input = [8, 0, 17, 4, 1, 12]
# start_input = [0,3,6] # example 1, P1=436, P2=175594
# start_input = [1,3,2] # example 2, P1=1    P2=2578
# start_input = [2,1,3] # example 3, P1=27   P2=3544142
# start_input = [1,2,3] # example 4, P1=78   P2=261214

class Game
  def initialize(values)
    @game = values.dup

    @last_occurences = {}
    values.each_index { |i| @last_occurences[values[i]] = i }
  end

  def last_value
    @game.last
  end

  def run(turns)
    turn = @game.length
    last_value = @game.last
    while turn < turns
      value = if @last_occurences.has_key?(last_value)
                turn - 1 - @last_occurences[last_value]
              else
                0
              end
      @last_occurences[last_value] = turn - 1
      @game[turn] = value
      last_value = value

      turn += 1
    end
  end
end

game = Game.new(start_input)

# Part 1
game.run(2020)
puts "Day 15.1: after 2020 rounds, the last number is #{game.last_value.to_s.green}"

# Part 2
game.run(30_000_000)
puts "Day 15.1: after 30,000,000 rounds, the last number is #{game.last_value.to_s.green}"
