require "colorize"

passwords = []
File.open('../input/day-02.txt').each do |line|
  lineparts = line.split(":")
  passwords << {lineparts[1].strip => lineparts[0].split}
end

# Part 1
def validate_password(password, rules)
  valid_chars = password.gsub(/[^#{rules[1]}]/, "").size

  lengths = rules[0].split("-")
  valid_chars >= lengths[0].to_i && valid_chars <= lengths[1].to_i
end

valid_passwords = passwords.select { |v| validate_password(v.first[0], v.first[1]) }
puts "Day  2.1: #{valid_passwords.length.to_s.green} valid passwords"

# Part 2
def toboggan_valid_password(password, rules)
  positions = rules[0].split("-")

  position1_valid = password[positions[0].to_i - 1] == rules[1]
  position2_valid = password[positions[1].to_i - 1] == rules[1]

  position1_valid ^ position2_valid
end

valid_passwords = passwords.select { |v| toboggan_valid_password(v.first[0], v.first[1]) }
puts "Day  2.2: #{valid_passwords.length.to_s.green} valid passwords"
