require "colorize"

input1 = 8335663
input2 = 8614349
# example
# input1 = 5764801
# input2 = 17807724

class Cypher
  attr_reader :encryption_key

  def initialize(public_key)
    @public_key = public_key
    @subject_number = 7
  end

  def determine_loop
    value = 1
    loop = 0

    while value != @public_key
      value = (value * @subject_number) % 20201227
      loop += 1
    end

    @loop = loop
  end

  def calculate_encryption_key(other_public_key)
    value = 1
    loop = 0
    while loop < @loop
      value = (value * other_public_key) % 20201227
      loop += 1
    end

    @encryption_key = value
  end

  def to_s
    "Cypher[#{@loop},#{@encryption_key}]"
  end
end

cypher1 = Cypher.new(input1)
cypher2 = Cypher.new(input2)
cypher1.determine_loop
cypher2.determine_loop
cypher1.calculate_encryption_key(input2)
cypher2.calculate_encryption_key(input1)

puts "Day 25.1: the encryption key is #{cypher1.encryption_key.to_s.green}"
