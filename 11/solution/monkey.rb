# frozen_string_literal: true

class Solution::Monkey
  attr_accessor :inspects_count, :index, :items, :operation, :divisible, :true_to, :false_to

  def initialize
    @items = []
    @inspects_count = 0
  end

  def append_item(item)
    @items << item
  end

  def worry_level_for(item)
    old = item

    eval(operation)
  end
end
