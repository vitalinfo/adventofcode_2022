# frozen_string_literal: true

require_relative '../base'

class Solution < Base
  private

  def perform1
    perform_with do |first, second|
      (first - second).empty? || (second - first).empty?
    end
  end

  def perform2
    perform_with do |first, second|
      (first & second).any?
    end
  end

  def perform_with
    res = 0

    input_lines.each do |line|
      first, second = line.strip.split(',')

      first = range_from(first)
      second = range_from(second)

      res += 1 if yield(first, second)
    end

    res
  end

  def range_from(value)
    from, to = value.split('-')
    (from.to_i..to.to_i).to_a
  end
end
