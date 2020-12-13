module Day11
  class Seats
    attr_reader :seats, :strategy

    def initialize(seats, strategy)
      @seats = seats
      @strategy = strategy
    end

    def next_iteration
      next_iteration = clone(seats)

      seats.each_index do |y|
        x = 0
        while x < seats[y].length
          char = get_seat(x, y)
          seats_taken = strategy.seats_taken(self, x, y)
          if char == 'L' && seats_taken == 0
            next_iteration[y][x] = '#'
          elsif char == '#' && seats_taken >= strategy.min_seats
            next_iteration[y][x] = 'L'
          end
          x += 1
        end
      end

      Seats.new(next_iteration, strategy)
    end

    def occupied_seats
      count = 0
      seats.each do |s|
        s.each_char do |c|
          count += 1 if c == '#'
        end
      end

      count
    end

    def get_seat(x, y)
      return nil if x < 0
      return nil if x >= seats[0].length
      return nil if y < 0
      return nil if y >= seats.length

      seats[y][x]
    end

    def ==(other)
      other.class == self.class && other.seats == self.seats
    end

    def to_s
      seats.join("\n")
    end

    private

    def clone(seats)
      new_seats = []
      seats.each { |s| new_seats << s.dup }
      new_seats
    end
  end
end