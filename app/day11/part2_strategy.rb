module Day11
  class Part2Strategy
    def seats_taken(seats, x, y)
      count = 0

      count += 1 if find_seat(seats, x, y, -1, -1) == "#"
      count += 1 if find_seat(seats, x, y, 0, -1) == "#"
      count += 1 if find_seat(seats, x, y, 1, -1) == "#"
      count += 1 if find_seat(seats, x, y, -1, 0) == "#"
      count += 1 if find_seat(seats, x, y, 1, 0) == "#"
      count += 1 if find_seat(seats, x, y, -1, 1) == "#"
      count += 1 if find_seat(seats, x, y, 0, 1) == "#"
      count += 1 if find_seat(seats, x, y, 1, 1) == "#"

      count
    end

    def min_seats
      5
    end

    private

    def find_seat(seats, x, y, diff_x, diff_y)
      the_x = x
      the_y = y
      begin
        the_x += diff_x
        the_y += diff_y

        seat = seats.get_seat(the_x, the_y)
      end while seat == "."

      return seat
    end
  end
end