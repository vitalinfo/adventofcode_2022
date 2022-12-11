# frozen_string_literal: true

require_relative '../base'

class Solution < Base

  private

  def perform1
    perform_with(4)
  end

  def perform2
    perform_with(14)
  end

  def perform_with(buffer_size)
    buffer = []
    input.split('').each_with_index do |char, index|
      buffer << char

      if buffer.size == buffer_size
        if buffer.uniq.size == buffer_size
          return index + 1
        else
          buffer.shift
        end
      end
    end
  end
end
