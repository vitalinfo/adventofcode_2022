# frozen_string_literal: true

require_relative '../base'

class Solution < Base
  STACKS = {
    1 => %w[J Z G V T D B N],
    2 => %w[F P W D M R S],
    3 => %w[Z S R C V],
    4 => %w[G H P Z J T R],
    5 => %w[F Q Z D N J C T],
    6 => %w[M F S G W P V N],
    7 => %w[Q P B V C G],
    8 => %w[N P B Z],
    9 => %w[J P W]
  }.freeze

  private

  def perform1
    perform_with do |res, from, count|
      res[from].shift(count).reverse
    end
  end

  def perform2
    perform_with do |res, from, count|
      res[from].shift(count)
    end
  end

  def perform_with
    res = Marshal.load(Marshal.dump(STACKS))

    input_lines.each do |line|
      count, from, to = line.strip.match(/move (\d+) from (\d+) to (\d+)/).to_a[1..].map(&:to_i)

      items = yield(res, from, count)
      res[to] = items + res[to]
    end

    res.values.map(&:first).join
  end
end
