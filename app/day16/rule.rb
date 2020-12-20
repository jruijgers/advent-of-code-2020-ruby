module Day16
  class Rule
    attr_reader :name

    def self.parse(rule)
      parts = rule.split(": ")

      ranges = parts[1].split("or").map do |p|
        p.strip.split("-").map { |v| v.to_i}
      end

      new(parts[0], ranges)
    end

    def initialize(name, ranges)
      @name = name
      @ranges = ranges
      @position = nil
    end

    def valid?(value)
      valid = false

      @ranges.each do |range|
        valid |= range[0] <= value && range[1] >= value
      end

      valid
    end

    def to_s
      "#{@name}: #{@ranges.map { |v| v.join("-")}.join(",")}"
    end
  end
end