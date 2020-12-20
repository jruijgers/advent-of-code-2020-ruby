module Day16
  class Ticket
    def initialize(values)
      @values = values.split(",").map { |v| v.to_i }
    end

    def value(index)
      @values[index]
    end

    def valid?(rules)
      valid = true

      @values.each do |value|
        valid_value = false
        rules.each do |rule|
          valid_value |= rule.valid?(value)
        end
        valid &= valid_value
      end

      valid
    end

    def valid_rules(position, rules)
      invalid_rules = []
      rules.each do |rule|
        invalid_rules << rule unless rule.valid?(@values[position])
      end

      rules - invalid_rules
    end

    def invalid_values(rules)
      invalid_values = []

      @values.each do |value|
        valid = false
        rules.each do |rule|
          valid |= rule.valid?(value)
        end
        invalid_values << value unless valid
      end

      invalid_values
    end

    def to_s
      "Ticket[#{@values.join(",")}]"
    end
  end
end