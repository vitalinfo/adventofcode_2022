# frozen_string_literal: true

require 'json'
require_relative '../base'

class Solution < Base
  DIVIDED_PACK1 = [[2]].freeze
  DIVIDED_PACK2 = [[6]].freeze

  def initialize
    @input = []
    parse_input
  end

  private

  attr_reader :input

  def parse_input
    group = []
    input_lines.each do |line|
      if line.strip.empty?
        input << group
        group = []
        next
      end
      group << JSON.parse(line.strip)
    end
    input << group
  end

  def perform1
    res = 0
    input.each_with_index do |item, index|
      res += index + 1 if ordered?(item[0], item[1])
    end
    res
  end

  def perform2
    new_input = input.flatten(1).concat([DIVIDED_PACK1, DIVIDED_PACK2])

    sorted = new_input.sort do |right, left|
      value = ordered?(left, right)
      value ? 1 : -1
    end
    (sorted.index(DIVIDED_PACK1) + 1) * (sorted.index(DIVIDED_PACK2) + 1)
  end

  def ordered?(left, right)
    return ordered?(Array(left), Array(right)) if left.class != right.class

    if left.is_a?(Integer)
      return if left == right

      return left < right
    end

    left.zip(right).each do |new_left, new_right|
      next if new_right.nil?

      value = ordered?(new_left, new_right)
      return value unless value.nil?
    end

    return left.size < right.size if left.size != right.size
  end
end
