# frozen_string_literal: true

require_relative '../base'

class Solution < Base
  require_relative 'solution/part1'
  require_relative 'solution/part2'

  def perform
    puts("Part 1 result: #{perform1}")
    puts('Part 2 result:')
    perform2
  end

  private

  def perform1
    Solution::Part1.new(input_lines).perform
  end

  def perform2
    Solution::Part2.new(input_lines).perform.each_slice(40).to_a.each do |line|
      puts line.join
    end
  end
end
