# frozen_string_literal: true

require_relative '../base'

class Solution < Base
  def initialize
    @forest = input_lines.to_a.map { |line| line.strip.split('').map(&:to_i) }
  end

  private

  attr_reader :forest

  def perform1
    res = 0

    (0...forest.size).each do |i|
      (0...forest[i].size).each do |j|
        res += 1 if visible?(forest, i, j)
      end
    end

    res
  end

  def perform2
    res = 0

    (0...forest.size).each do |i|
      (0...forest[i].size).each do |j|
        score = score_for(forest, i, j)
        res = score if score > res
      end
    end

    res
  end

  def score_for(forest, i, j)
    height = forest[i][j]

    dirty = false
    left = forest[i][0...j].reverse.select do |value|
      res = !dirty
      dirty = true unless value < height
      res
    end.size

    dirty = false
    right = forest[i][(j + 1)...forest[i].size].select do |value|
      res = !dirty
      dirty = true unless value < height
      res
    end.size

    dirty = false
    above = forest[0...i].reverse.select do |value|
      res = !dirty
      dirty = true unless value[j] < height
      res
    end.size

    dirty = false
    below = forest[(i + 1)...forest.size].select do |value|
      res = !dirty
      dirty = true unless value[j] < height
      res
    end.size

    above * left * right * below
  end

  def visible?(forest, i, j)
    return true if i.zero? || j.zero? || i == forest.size - 1 || j == forest[i].size - 1

    height = forest[i][j]

    left = forest[i][0...j].all? { |value| value < height }
    right = forest[i][j + 1...forest[i].size].all? { |value| value < height }
    above = forest[0...i].all? { |value| value[j] < height }
    below = forest[i + 1...forest.size].all? { |value| value[j] < height }

    left || right || above || below
  end
end
