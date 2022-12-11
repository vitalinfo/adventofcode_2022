# frozen_string_literal: true

class Solution::Rope
  require_relative 'rope_item'

  attr_reader :items

  def initialize(count)
    @items = Array.new(count).map { |_index| Solution::RopeItem.new }

    (0..count - 2).each do |index|
      items[index].tail = items[index + 1]
    end
  end

  def head
    items.first
  end

  def tail
    items.last
  end
end
