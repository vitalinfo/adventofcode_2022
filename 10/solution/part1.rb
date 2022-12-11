# frozen_string_literal: true

class Solution::Part1
  TICKS = [20, 60, 100, 140, 180, 220].freeze

  def initialize(input_lines)
    @value = 1
    @tick = 0
    @res = 0
    @input_lines = input_lines
  end

  def perform
    @input_lines.each do |line|
      command, num = line.strip.split
      num = num.nil? ? 0 : num.to_i
      ticks = command == 'addx' ? 2 : 1

      ticks.times do
        @tick += 1

        @res += @value * @tick if TICKS.include?(@tick)
      end

      @value += num
    end

    @res
  end
end
