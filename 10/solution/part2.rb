# frozen_string_literal: true

class Solution::Part2
  def initialize(input_lines)
    @sprite = %w[# # #] + Array.new(37, ' ')
    @crt = []
    @value = 1
    @tick = 0
    @input_lines = input_lines
  end

  def perform
    @input_lines.each do |line|
      command, num = line.strip.split
      num = num.nil? ? 0 : num.to_i
      ticks = command == 'addx' ? 2 : 1

      ticks.times do
        index = @tick - 40 * (@tick / 40)
        @crt << @sprite[index] == '#' ? '#' : ' '

        @tick += 1
      end

      @value += num
      @sprite = Array.new(40, ' ')

      3.times { |index| @sprite[@value + index - 1] = '#' if @value + index - 1 >= 0 }
    end

    @crt
  end
end
