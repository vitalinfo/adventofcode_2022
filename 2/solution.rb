# frozen_string_literal: true

require_relative '../base'

class Solution < Base
  SCORE = {
    'X' => 1,
    'Y' => 2,
    'Z' => 3
  }

  REMATCH = {
    'A' => 'X', # Rock
    'B' => 'Y', # Paper
    'C' => 'Z'  # Scissors
  }

  LOSE_MATCH = {
    'X' => 'Z',
    'Y' => 'X',
    'Z' => 'Y'
  }

  WIN_MATCH = {
    'X' => 'Y',
    'Y' => 'Z',
    'Z' => 'X'
  }

  private

  def perform1
    res = 0

    input_lines.each do |line|
      opponent, mine = line.split

      rematched = REMATCH[opponent]

      res += SCORE[mine]

      if mine == rematched
        res += 3
      else
        if (mine == 'X' && rematched == 'Z') ||
           (mine == 'Y' && rematched == 'X') ||
           (mine == 'Z' && rematched == 'Y')
          res += 6
        end
      end

      res
    end

    res  end

  def perform2
    res = 0

    input_lines.each do |line|
      opponent, result = line.split

      rematched = REMATCH[opponent]
      case result
      when 'X'
        mine = LOSE_MATCH[rematched]
      when 'Y'
        mine = rematched
        res += 3
      when 'Z'
        mine = WIN_MATCH[rematched]
        res += 6
      end

      res += SCORE[mine]
    end

    res
  end
end
