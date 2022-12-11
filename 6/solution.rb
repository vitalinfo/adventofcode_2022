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

      next if buffer.size != buffer_size

      return index + 1 if buffer.uniq.size == buffer_size

      buffer.shift
    end
  end
end
