module Day08
  class Program
    attr_reader :accumulator, :instructions

    def initialize
      @instructions = []
    end

    def add_instruction(instruction)
      @instructions << instruction
    end

    def execute
      @accumulator = 0
      instruction_counter = 0
      executed_instructions = []

      until executed_instructions.include?(instruction_counter) || instruction_counter >= @instructions.length
        executed_instructions << instruction_counter
        instruction = @instructions[instruction_counter]

        if instruction.nil?
          # puts instruction_counter
          # puts @instructions.length
        end

        if instruction.type == "acc"
          @accumulator += instruction.value
          instruction_counter += 1
        elsif instruction.type == "nop"
          instruction_counter += 1
        elsif instruction.type == "jmp"
          instruction_counter += instruction.value
        end
      end

      instruction_counter == @instructions.length
    end
  end
end
