# frozen_string_literal: true

require_relative '../base'

class Solution < Base
  VALUES =
    Hash[*(
      ('a'..'z').to_a.map.each_with_index { |l, i| [l, i + 1] }.flatten +
        ('A'..'Z').to_a.map.each_with_index { |l, i| [l, i + 27] }.flatten
    )]

  private

  def perform1
    res = 0

    input_lines.each do |line|
      arr = line.strip.split('')

      first = arr[0..arr.size / 2 - 1]
      second = arr[arr.size / 2..]

      common = (first & second).first

      res += VALUES[common]
    end

    res
  end

  def perform2
    res = 0

    input_lines.map { |line| line.strip.split('') }.each_slice(3) do |lines|
      common = lines.reduce(&:&).first

      res += VALUES[common]
    end

    res
  end
end
