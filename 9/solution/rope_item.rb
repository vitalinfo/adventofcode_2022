# frozen_string_literal: true

require 'ostruct'

class Solution::RopeItem
  attr_reader :position, :positions
  attr_accessor :tail

  def initialize
    @position = OpenStruct.new(x: 0, y: 0)
    @positions = [position.clone]
  end

  def move(direction, steps)
    steps.times do
      position.x = position.x + direction.x
      position.y = position.y + direction.y

      positions << position.clone

      next unless diagonal?

      tail.move(OpenStruct.new(x: sign(position.x - tail.position.x),
                               y: sign(position.y - tail.position.y)),
                1)
    end
  end

  private

  def sign(number)
    return 0 if number.zero?

    number.positive? ? 1 : -1
  end

  def diagonal?
    return false if tail.nil?

    [(position.x - tail.position.x).abs, (position.y - tail.position.y).abs].max > 1
  end
end
