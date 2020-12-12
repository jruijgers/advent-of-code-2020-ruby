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

valid_passports = passports.select { |p| valid_passport?(p) }
puts "Day  4.1: #{valid_passports.length.to_s.green} passports with required fields"

# Part 2
def valid_byr(passport_fields)
  byr = passport_fields["byr"].to_i

  byr >= 1920 && byr <= 2002
end

def valid_iyr(passport_fields)
  iyr = passport_fields["iyr"].to_i

  iyr >= 2010 && iyr <= 2020
end

def valid_eyr(passport_fields)
  eyr = passport_fields["eyr"].to_i

  eyr >= 2020 && eyr <= 2030
end

def valid_hgt(passport_fields)
  hgt = passport_fields["hgt"]

  if hgt.include?("cm")
    hgt = hgt.gsub("cm", "").to_i
    hgt >= 150 && hgt <= 193
  elsif hgt.include?("in")
    hgt = hgt.gsub("in", "").to_i
    hgt >= 59 && hgt <= 76
  else
    false
  end
end

def valid_hcl(passport_fields)
  hcl = passport_fields["hcl"]

  hcl.gsub(/#[a-f0-9]{6}/, "").size == 0
end

def valid_ecl(passport_fields)
  ecl = passport_fields["ecl"]

  ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].include?(ecl)
end

def valid_pid(passport_fields)
  pid = passport_fields["pid"]

  pid.gsub(/[0-9]{9}/, "").size == 0
end

def valid_password_field_values(passport)
  passport_fields = {}
  passport.split.each { |f| r = f.split(":"); passport_fields[r[0]] = r[1] }

  valid = valid_byr(passport_fields)
  valid &= valid_iyr(passport_fields)
  valid &= valid_eyr(passport_fields)
  valid &= valid_hgt(passport_fields)
  valid &= valid_hcl(passport_fields)
  valid &= valid_ecl(passport_fields)
  valid &= valid_pid(passport_fields)

  valid
end

fully_valid_passports = valid_passports.select { |p| valid_password_field_values(p) }
puts "Day  4.2: #{fully_valid_passports.length.to_s.green} fully valid passports"