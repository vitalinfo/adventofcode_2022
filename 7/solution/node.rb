# frozen_string_literal: true

class Solution::Node
  include Enumerable

  DIR_TYPE = 'dir'
  FILE_TYPE = 'file'

  attr_reader :type, :name, :parent, :children
  attr_accessor :size

  def initialize(type:, name:, parent: nil, size: 0)
    @type = type
    @name = name
    @parent = parent
    @size = size.to_i
    @children = []
  end

  def append(node)
    children << node
  end

  def each(&block)
    block.call(self)
    children.each { |node| node.each(&block) }
  end

  def refresh_size!
    @size = size_for!(self)
  end

  private

  def size_for!(node)
    return node.size if node.type == FILE_TYPE

    res = 0
    node.children.each do |child|
      res += if child.type == FILE_TYPE
               child.size
             else
               child.size = size_for!(child)
             end
    end

    res
  end
end
