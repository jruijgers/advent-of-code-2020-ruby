require "colorize"

# load input
passports = []
current_passport = ""
File.open("../input/day04.txt").each do |passport_line|
  if passport_line.strip == ""
    passports << current_passport
    current_passport = ""
  else
    current_passport = "#{current_passport} #{passport_line.strip}".strip
  end
end
passports << current_passport

# Part 1
def valid_passport?(passport)
  required_fields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
  valid = true
  required_fields.each do |field|
    valid &= passport.include?(field)
  end

  valid
end

valid_passports = passports.select { |p| valid_passport?(p)}
puts "Day  4.1: #{valid_passports.length.to_s.green} valid passports"
