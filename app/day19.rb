require "colorize"

rules = []
messages = []
parsing = "rules"

class Rule
  def self.parse(line, rules)
    elements = line.strip.split("|").map { |e| e.strip.split(" ") }

    new(elements, rules)
  end

  def initialize(elements, rules)
    @elements = elements
    @rules = rules
  end

  def to_re
    expression = ""
    if @elements.length == 1 &&
      if @elements.first.length == 1
        if @elements.first.first.to_i > 0
          expression += @rules[@elements.first.first.to_i].to_re
        else
          expression += @elements.first.first[1]
        end
      else
        @elements.first.each { |r| expression += @rules[r.to_i].to_re }
      end
    elsif @rules[8] == self || @rules[11] == self
      expression += "("
      (1..5).each do |times|
        expression += "|" if times > 1
        @elements[0].each do |r|
          expression += @rules[r.to_i].to_re
          expression += "{#{times}}"
        end
      end
      expression += ")"
    else
      expression += "("
      @elements.each_index do |i|
        expression += "|" if i > 0
        @elements[i].each { |r| expression += @rules[r.to_i].to_re }
      end
      expression += ")"
    end

    expression
  end

  def to_s
    @elements.map { |e| e.join(" ") }.join(" | ")
  end
end

File.open("../input/day19.txt").each do |line|
  if line.strip == ""
    parsing = "messages"
  elsif parsing == "rules"
    parts = line.strip.split(": ")
    rules[parts[0].to_i] = Rule.parse(parts[1], rules)
  else
    messages << line.strip
  end
end

re = rules[0].to_re
valid_messages = messages.select { |m| m.match(/^#{re}$/) }

puts "Day 19.1: number of valid messages is #{valid_messages.length.to_s.green}"

rules[8] = Rule.parse("42 | 42 8", rules)
rules[11] = Rule.parse("42 31 | 42 11 31", rules)

re = rules[0].to_re
valid_messages = messages.select { |m| m.match(/^#{re}$/) }

# must be lower than 413
puts "Day 19.2: number of valid messages is #{valid_messages.length.to_s.green}"
