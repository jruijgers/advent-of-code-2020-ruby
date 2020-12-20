require "colorize"

lines = []
File.open("../input/day18.txt").each { |l| lines << l.strip }
# lines << "1 + 2 * 3 + 4 * 5 + 6" # 71
# lines << "1 + (2 * 3) + (4 * (5 + 6))" # 51
# lines << "2 * 3 + (4 * 5)" # 26
# lines << "5 + (8 * 3 + 9 + 3 * 4 * 3)" # 437
# lines << "5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))" # 12240
# lines << "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2" # 13632

class SimpleOperation
  def self.parse(line)
    operations = []

    last_operation = nil
    operator = nil
    left = nil
    right = nil

    line.split("").each do |part|
      next if part == " "

      if part == "("
        operations << [operator, left, right]
        operator = nil
        left = nil
        right = nil
      elsif part == ")"
        (operator, left, right) = operations.pop
        if left.nil?
          left = last_operation
        elsif right.nil?
          right = last_operation
        end
      elsif left.nil?
        left = part.to_i
      elsif operator.nil?
        operator = part
      elsif right.nil?
        right = part.to_i
      end

      unless left.nil? || right.nil? || operator.nil?
        last_operation = Operation.new(operator, left, right)
        operator = nil
        left = last_operation
        right = nil
      end
    end

    last_operation
  end

  def initialize(operator, left, right)
    @operator = operator
    @left = left
    @right = right
  end

  def calculate
    left = @left.is_a?(SimpleOperation) ? @left.calculate : @left
    right = @right.is_a?(SimpleOperation) ? @right.calculate : @right

    if @operator == "*"
      left * right
    elsif @operator == "+"
      left + right
    else
      raise "unknown operator (#{@operator}"
    end
  end

  def to_s
    s = ""
    s += @left.is_a?(SimpleOperation) ? "(#{@left})" : @left.to_s
    s += " '#{@operator}' "
    s += @right.is_a?(SimpleOperation) ? "(#{@right})" : @right.to_s
    s
  end
end

sum = 0
lines.each do |line|
  operation = SimpleOperation.parse(line)
  sum += operation.calculate
end

puts "Day 18.1: sum of homework is #{sum.to_s.green}"
