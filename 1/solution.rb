# frozen_string_literal: true

require_relative '../base'

class Solution < Base
  private

  def perform1
    calories_for.values.max
  end

  def perform2
    calories_for.values.sort.reverse.first(3).sum
  end

  def calories_for
    @calories_for ||= begin
      res = {}
      index = 0

      input_lines.each do |line|
        index += 1 if line.strip.empty?
        res[index] ||= 0
        res[index] += line.to_i
      end
      res
    end
  end
end
