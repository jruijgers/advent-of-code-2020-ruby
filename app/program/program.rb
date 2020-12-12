module Program
  class Program
    def initialize
      @instructions = []
    end

    def add_instruction(instruction)
      @instructions << instruction
    end

    def execute
      accumulator = 0
      instruction_counter = 0
      executed_instructions = []

      while !executed_instructions.include? instruction_counter
        executed_instructions << instruction_counter
        instruction = @instructions[instruction_counter]

        if instruction.type == "acc"
          accumulator += instruction.value
          instruction_counter += 1
        elsif instruction.type == "nop"
          instruction_counter += 1
        elsif instruction.type == "jmp"
          instruction_counter += instruction.value
        end
      end

      accumulator
    end
  end
end
