# frozen_string_literal: true

require 'ostruct'
require_relative '../base'

class Solution < Base
  require_relative 'solution/rope'

  DIRECTIONS = {
    'U' => OpenStruct.new(x: 0, y: 1),
    'D' => OpenStruct.new(x: 0, y: -1),
    'L' => OpenStruct.new(x: -1, y: 0),
    'R' => OpenStruct.new(x: 1, y: 0)
  }.freeze

  private

  def perform1
    perform_for(Solution::Rope.new(2))
  end

  def perform2
    perform_for(Solution::Rope.new(10))
  end

  def perform_for(rope)
    input_lines.each do |line|
      direction, steps = line.strip.split

      rope.head.move(DIRECTIONS[direction], steps.to_i)
    end

    rope.tail.positions.uniq.size
  end
end
