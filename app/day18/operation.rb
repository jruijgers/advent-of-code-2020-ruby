module Day18
  class Operation
    attr_accessor :operator, :left, :right

    def initialize(operator, left, right)
      @operator = operator
      @left = left
      @right = right
    end

    def calculate
      left = @left.is_a?(Operation) ? @left.calculate : @left
      right = @right.is_a?(Operation) ? @right.calculate : @right

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
      s += @left.is_a?(Operation) ? "(#{@left})" : @left.to_s
      s += " '#{@operator}' "
      s += @right.is_a?(Operation) ? "(#{@right})" : @right.to_s
      s
    end
  end
end