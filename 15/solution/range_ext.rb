# frozen_string_literal: true

class Solution::RangeExt
  attr_accessor :ranges

  def initialize(ranges)
    @ranges = ranges.sort_by(&:begin)
  end

  def cover?(value)
    ranges.any? { |r| r.cover?(value) }
  end

  def count
    ranges.sum(&:count)
  end

  def merge_overlapping
    current = ranges.first
    new_ranges = []

    ranges.drop(1).each do |range|
      new_range = merge(current, range)

      if new_range.nil?
        new_ranges << current
        current = range
      else
        current = new_range
      end
    end

    new_ranges << current

    Solution::RangeExt.new(new_ranges)
  end

  private

  def merge(range1, range2)
    return if range1.end < range2.begin || range2.end < range1.begin

    [range1.begin, range2.begin].min..[range1.end, range2.end].max
  end
end
