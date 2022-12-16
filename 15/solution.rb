# frozen_string_literal: true

require 'set'
require_relative '../base'

class Solution < Base
  require_relative 'solution/range_ext'

  TARGET_Y = 2_000_000
  MAX_Y = 4_000_000

  def initialize
    @matrix = {}
    @beacons = Set.new
    parse_input
  end

  private

  attr_reader :matrix, :beacons

  def exclusion_range(row)
    ranges = []

    matrix.each do |sensor, radius|
      sensor_x, sensor_y = sensor
      vertical_dist = (sensor_y - row).abs

      next if vertical_dist >= radius

      horiz_dist = radius - vertical_dist
      range = (sensor_x - horiz_dist)..(sensor_x + horiz_dist)
      ranges << range
    end

    Solution::RangeExt.new(ranges).merge_overlapping
  end

  def parse_input
    input_lines.each do |line|
      sensor_x, sensor_y, beacon_x, beacon_y = line.scan(/-?\d+/).map(&:to_i)
      dist = manhattan_dist(sensor_x, sensor_y, beacon_x, beacon_y)
      matrix[[sensor_x, sensor_y]] = dist
      beacons.add([beacon_x, beacon_y])
    end
  end

  def manhattan_dist(x1, y1, x2, y2)
    (x1 - x2).abs + (y1 - y2).abs
  end

  def perform1
    full_range = exclusion_range(TARGET_Y)

    contained_beacons = beacons.filter do |beacon_x, beacon_y|
      TARGET_Y == beacon_y && full_range.cover?(beacon_x)
    end.count

    full_range.count - contained_beacons
  end

  def perform2
    MAX_Y.times.each do |row|
      full_range = exclusion_range(row)

      return (full_range.ranges[0].end + 1) * MAX_Y + row if full_range.ranges.count > 1
    end
  end
end
