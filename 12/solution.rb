# frozen_string_literal: true

require 'ostruct'
require_relative '../base'

class Solution < Base
  DIRECTIONS = [
    OpenStruct.new(x: 0, y: 1),
    OpenStruct.new(x: 0, y: -1),
    OpenStruct.new(x: -1, y: 0),
    OpenStruct.new(x: 1, y: 0)
  ].freeze

  START_VALUE = 0
  END_VALUE = 26
  DEC_ON = 97
  FAKE_MAX = 50
  CLOSE_TO_END = 24

  def initialize
    @matrix = []
    @start_positions = []
    @end_position = nil
    @paths = []
    @visited = {}
    parse_input
  end

  private

  attr_reader :matrix, :start_positions, :end_position, :paths, :visited

  def parse_input
    input_lines.each do |line|
      matrix << line.strip.split('')
    end

    matrix.each_with_index do |line, i|
      line.each_with_index do |value, j|
        case value
        when 'S'
          @start_positions << OpenStruct.new(x: i, y: j, s: true)
          matrix[i][j] = START_VALUE
        when 'E'
          @end_position = OpenStruct.new(x: i, y: j)
          matrix[i][j] = END_VALUE # NOTE: mark end with biggest value
        when 'a'
          matrix[i][j] = START_VALUE
          @start_positions << OpenStruct.new(x: i, y: j, s: false)
        else
          matrix[i][j] = value.ord - DEC_ON # NOTE: fit to [a..z] to the range [0..25]
        end
      end
    end
  end

  def perform1
    start_position = start_positions.detect(&:s)

    perform_one(start_position.x, start_position.y, 0)
    paths << visited["#{end_position.x}:#{end_position.y}"]

    paths.compact.min
  end

  def perform2
    start_positions.each do |start_position|
      perform_one(start_position.x, start_position.y, 0)
      paths << visited["#{end_position.x}:#{end_position.y}"]
    end

    paths.compact.min
  end

  def perform_one(x, y, steps)
    return visited if !visited["#{x}:#{y}"].nil? && steps >= visited["#{x}:#{y}"]

    visited["#{x}:#{y}"] = steps
    current = matrix[x][y]

    return visited if current == END_VALUE

    up, down, left, right = values_for(x, y)

    visited = perform_one(x, y - 1, steps + 1) if up - current < 2 || (current == CLOSE_TO_END && up == END_VALUE)
    visited = perform_one(x, y + 1, steps + 1) if down - current < 2 || (current == CLOSE_TO_END && down == END_VALUE)
    visited = perform_one(x - 1, y, steps + 1) if left - current < 2 || (current == CLOSE_TO_END && left == END_VALUE)
    visited = perform_one(x + 1, y, steps + 1) if right - current < 2 || (current == CLOSE_TO_END && right == END_VALUE)
    visited
  end

  def values_for(x, y)
    up = (y - 1 >= 0 ? matrix[x][y - 1] : FAKE_MAX)
    down = (y + 1 <= matrix.first.size - 1 ? matrix[x][y + 1] : FAKE_MAX)
    left = (x - 1 >= 0 ? matrix[x - 1][y] : FAKE_MAX)
    right = (x + 1 <= matrix.size - 1 ? matrix[x + 1][y] : FAKE_MAX)

    [up, down, left, right]
  end
end
