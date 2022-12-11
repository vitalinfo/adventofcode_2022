# frozen_string_literal: true

require 'ostruct'
require_relative '../base'

class Solution < Base
  require_relative 'solution/monkey'

  private

  attr_reader :monkeys

  def parse_input
    monkey = Solution::Monkey.new
    input_lines.each do |line|
      if line.strip.empty?
        monkeys << monkey
        monkey = Solution::Monkey.new
      end

      monkey.index = Regexp.last_match(1).to_i unless line.match(/Monkey (\d):/).nil?
      unless line.match(/Starting items: (.+)/).nil?
        monkey.items = Regexp.last_match(1).split(', ').map(&:to_i)
      end
      monkey.operation = Regexp.last_match(1) unless line.match(/Operation: new = (.+)/).nil?
      monkey.divisible = Regexp.last_match(1).to_i unless line.match(/Test: divisible by (\d+)/).nil?
      monkey.true_to = Regexp.last_match(1).to_i unless line.match(/If true: throw to monkey (\d)/).nil?
      monkey.false_to = Regexp.last_match(1).to_i unless line.match(/If false: throw to monkey (\d)/).nil?
    end

    monkeys << monkey
  end

  def perform1
    @monkeys = []
    parse_input

    20.times { perform_one(3) }

    sorted = monkeys.sort_by { |monkey| -monkey.inspects_count }
    sorted[0].inspects_count * sorted[1].inspects_count
  end

  def perform2
    return
    @monkeys = []
    parse_input

    1000.times { perform_one(1) }

    p monkeys
    # sorted = monkeys.sort_by { |monkey| -monkey.inspects_count }
    # sorted[0].inspects_count * sorted[1].inspects_count
  end

  def perform_one(worry_level_divider)
    monkeys.each do |monkey|
      monkey.items.each do |item|
        worry_level = monkey.worry_level_for(item) / worry_level_divider
        index_to = worry_level.divmod(monkey.divisible).last.zero? ? monkey.true_to : monkey.false_to
        monkeys[index_to].items << worry_level
        monkey.inspects_count += 1
      end
      monkey.items = []
    end
  end
end
