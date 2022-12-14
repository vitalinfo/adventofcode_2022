# frozen_string_literal: true

require 'json'
require_relative '../base'

class Solution < Base
  STONE = 1
  SAND = 2
  SAND_START_X = 500
  SAND_START_Y = 0
  DIRECTIONS = [
    [0, 1],
    [-1, 1],
    [1, 1]
  ]

  private

  attr_reader :matrix, :max_y

  def parse_matrix(lines, columns)
    res = Array.new(lines).map { Array.new(columns) }
    @max_y = 0
    input_lines.each do |line|
      points = line.strip.split(' -> ').map { |item| item.split(',').map(&:to_i) }

      (0...points.size - 1).each do |index|
        x0, y0 = points[index]
        x1, y1 = points[index + 1]

        # NOTE: from smallest to biggest
        x0, x1 = x1, x0 unless x0 < x1
        y0, y1 = y1, y0 unless y0 < y1

        (y0..y1).each { |y| res[y][x0] = STONE } if x0 == x1
        (x0..x1).each { |x| res[y0][x] = STONE } if y0 == y1
        @max_y = y1 if max_y < y1
      end
    end
    res
  end

  def print
    matrix.each do |line|
      puts line[470..line.size - 100].map{|item| item || '.'}.join
    end
  end

  def new_sand_position(sx, sy)
    DIRECTIONS.each do |x, y|
      return [sx + x, sy + y, false] if matrix[sy + y][sx + x].nil?
    end

    [sx, sy, true]
  end

  def perform1
    @matrix = parse_matrix(200, 600)

    falling = false
    loop do
      sx = SAND_START_X
      sy = SAND_START_Y

      loop do
        if sy + 1 >= matrix.size
          falling = true
          break
        end

        sx, sy, rest = new_sand_position(sx, sy)
        break if rest
      end

      matrix[sy][sx] = SAND
      break if falling
    end

    matrix.flatten.count(SAND) - 1
  end

  def perform2
    @matrix = parse_matrix(1000, 1000)

    matrix[max_y + 2] = matrix[max_y + 2].map { STONE }

    falling = false
    loop do
      sx = SAND_START_X
      sy = SAND_START_Y

      loop do
        sx, sy, rest = new_sand_position(sx, sy)
        break if rest
      end

      matrix[sy][sx] = SAND
      break if sx == SAND_START_X && sy == SAND_START_Y
    end

    matrix.flatten.count(SAND)
  end
end
