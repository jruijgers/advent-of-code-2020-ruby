module Day18
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
  end
end