require "colorize"

boarding_passes = File.open("../input/day05.txt").map { |l| l.strip }

# Part 1
def seat_id(boarding_pass)
  valid_rows = [0, 127]
  for r in 0..6
    rows = (valid_rows[1] - valid_rows[0]) / 2
    if boarding_pass[r] == "F"
      valid_rows[1] = valid_rows[1] - rows - 1
    else
      valid_rows[0] = valid_rows[0] + rows + 1
    end
  end

  valid_seats = [0, 7]
  for s in 7..9
    seats = (valid_seats[1] - valid_seats[0]) / 2
    if boarding_pass[s] == "L"
      valid_seats[1] = valid_seats[1] - seats - 1
    else
      valid_seats[0] = valid_seats[0] + seats + 1
    end
  end

  valid_rows[0] * 8 + valid_seats[0]
end

found_seat_ids = boarding_passes.map { |b| seat_id(b) }

highest_seat_id = -1
found_seat_ids.each do |seat_id|
  highest_seat_id = seat_id if seat_id > highest_seat_id
end

puts "Day  5.1: highest seat ID is #{highest_seat_id.to_s.green}"

my_seat_id = -1
for seat_id in 1..highest_seat_id
  if !found_seat_ids.include?(seat_id) && found_seat_ids.include?(seat_id - 1) && found_seat_ids.include?(seat_id + 1)
    my_seat_id = seat_id
  end
end

puts "Day  5.2: my seat ID is #{my_seat_id.to_s.green}"