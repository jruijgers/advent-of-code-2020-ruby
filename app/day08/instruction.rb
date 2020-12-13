module Day08
  class Instruction
    attr_reader :type, :value

    def initialize(type, value)
      @type = type
      @value = value
    end

    def update
      if type == "jmp"
        @type = "nop"
      elsif type == "nop"
        @type = "jmp"
      end
    end

    def to_s
      "#{type} #{value}"
    end
  end
end