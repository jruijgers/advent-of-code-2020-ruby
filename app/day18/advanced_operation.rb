module Day18
  class AdvancedOperation
    def self.parse(line)
      operations = []

      current_operation = Operation.new(nil, nil, nil)

      line.split("").each do |part|
        next if part == " "

        if part == "("
          operations << current_operation
          current_operation = Operation.new(nil, nil, nil)
        elsif part == ")"
          operation = operations.pop
          if operation.left.nil?
            operation.left = current_operation
          else
            leaf = operation
            while leaf.right
              leaf = leaf.right
            end
            leaf.right = current_operation
          end
          current_operation = operation
        elsif current_operation.left.nil?
          current_operation.left = part.to_i
        elsif current_operation.operator.nil?
          current_operation.operator = part
        elsif part == "*"
          current_operation = Operation.new(part, current_operation, nil)
        elsif part == "+"
          current_operation.right = Operation.new(part, current_operation.right, nil)
        else
          # find rightmost empty leaf
          leaf = current_operation
          while leaf.right
            leaf = leaf.right
          end
          leaf.right = part.to_i
        end
      end

      current_operation
    end
  end
end