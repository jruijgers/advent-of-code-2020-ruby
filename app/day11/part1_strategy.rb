module Day11
  class Part1Strategy
    def seats_taken(seats, x, y)
      count = 0

      count += 1 if seats.get_seat(x - 1, y - 1) == "#"
      count += 1 if seats.get_seat(x, y - 1) == "#"
      count += 1 if seats.get_seat(x + 1, y - 1) == "#"
      count += 1 if seats.get_seat(x - 1, y) == "#"
      count += 1 if seats.get_seat(x + 1, y) == "#"
      count += 1 if seats.get_seat(x - 1, y + 1) == "#"
      count += 1 if seats.get_seat(x, y + 1) == "#"
      count += 1 if seats.get_seat(x + 1, y + 1) == "#"

      count
    end

    def min_seats
      4
    end
  end
end