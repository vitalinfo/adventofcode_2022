# frozen_string_literal: true

require_relative '../base'

class Solution < Base
  def initialize
    @valves = parse_input
    @distances = {}
  end

  private

  attr_reader :distances, :valves

  def parse_input
    input_lines.map { |line| line.scan(/\d+/).map(&:to_i) + line.scan(/[A-Z]{2}/) }
               .map { |item| { item[1] => { flow: item[0], conn: item[2..] } } }
               .reduce({}, :merge)
  end

  def perform1
    perform_for(%w[AA AA], 30, 0)
  end

  def perform2
    perform_for(%w[AA AA], 26, 26)
  end

  def distance_for(pos, to)
    k = { from: pos, to: to }
    return distances[k] if distances.key?(k)

    to_a = [to]
    to_na = []
    distance = 0
    until to_a.include?(pos)
      to_a.each do |to|
        to_na += valves.filter { |_k, v| v[:conn].include?(to) }.keys
      end
      to_a = to_na.uniq
      to_na = []
      distance += 1
    end
    distances[k] = distance

    distance
  end

  def moves_for(pos, rel, minute_rem, openn = [])
    moves = {}
    valves.each do |k, v|
      next if openn.include?(k) || (v[:flow]).zero?

      distance = distance_for(pos, k)
      rem = minute_rem - distance - 1
      next if rem.negative?

      release = v[:flow] * rem
      val = { rel: release + rel, open: openn + [k], pos: k }
      moves[rem] = if moves.key?(rem)
                     [val, moves[rem]].max_by { |v| v[:rel] }
                   else
                     val
                   end
    end
    moves
  end

  def perform_for(pos, minute_rem1, minute_rem2)
    moves = { [minute_rem1, minute_rem2] => { rel: 0, open: [], pos: pos } }
    best = 0
    until moves.size.zero?
      max_move = moves.max_by { |k, _v| k }
      pos_moves = moves_for(max_move[1][:pos][0], max_move[1][:rel], max_move[0][0], max_move[1][:open])
      pos_moves = pos_moves.map do |k, v|
        if k > max_move[0][1]
          [[k, max_move[0][1]], { rel: v[:rel], open: v[:open], pos: [v[:pos], max_move[1][:pos][1]] }]
        else
          [[max_move[0][1], k], { rel: v[:rel], open: v[:open], pos: [max_move[1][:pos][1], v[:pos]] }]
        end
      end.to_h
      if max_move[0].uniq.length == 1 && max_move[1][:pos].uniq.length > 1
        pos_moves2 = moves_for(max_move[1][:pos][1], max_move[1][:rel], max_move[0][0], max_move[1][:open])
        pos_moves2 = pos_moves2.map do |k, v|
          if k > max_move[0][1]
            [[k, max_move[0][1]], { rel: v[:rel], open: v[:open], pos: [v[:pos], max_move[1][:pos][0]] }]
          else
            [[max_move[0][1], k], { rel: v[:rel], open: v[:open], pos: [max_move[1][:pos][0], v[:pos]] }]
          end
        end.to_h
        pos_moves.merge!(pos_moves2) { |_k, v1, v2| [v1, v2].max_by { |v| v[:rel] } }
      end
      best = [best, max_move[1][:rel]].max
      moves.delete(max_move[0])
      moves.merge!(pos_moves) { |_k, v1, v2| [v1, v2].max_by { |v| v[:rel] } }
    end
    best
  end
end
