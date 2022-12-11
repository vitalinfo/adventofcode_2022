# frozen_string_literal: true

require_relative '../base'

class Solution < Base
  require_relative 'solution/node'

  SYSTEM_SIZE = 70_000_000
  SIZE_FOR_UPDATE = 30_000_000

  def initialize
    @root = Solution::Node.new(type: Node::DIR_TYPE, name: '/')
    @current = root
    parse_input
  end

  private

  attr_reader :current, :root

  def current_from(commands)
    return current.parent if commands[2] == '..'

    current.children.find { |node| node.name == commands[2] }
  end

  def parse_input
    input_lines.drop(1).each do |line|
      commands = line.strip.split

      case commands[0]
      when '$'
        @current = current_from(commands) if commands[1] == 'cd'
      when 'dir'
        current.append(Node.new(type: Node::DIR_TYPE, name: commands[1], parent: current))
      else
        current.append(Node.new(type: Node::FILE_TYPE, name: commands[1], size: commands.first, parent: current))
      end
    end

    root.refresh_size!
  end

  def perform1
    root.filter { |node| node.type == Node::DIR_TYPE && node.size < 100_000 }
        .map(&:size)
        .sum
  end

  def perform2
    free_space = SYSTEM_SIZE - root.size
    require_space = SIZE_FOR_UPDATE - free_space

    root.filter { |node| node.size >= require_space }
        .map(&:size)
        .min
  end
end
