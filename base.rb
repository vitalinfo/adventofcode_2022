class Base
  def part_1
    puts("Part 1 result: #{perform_1}")
  end

  def part_2
    puts("Part 2 result: #{perform_2}")
  end

  private

  def input_lines
    File.readlines(Object.const_source_location(self.class.name).first.gsub(/solution\.rb/, 'input.txt'))
  end

  def perform_1
    raise NotImplementedError
  end

  def perform_2
    raise NotImplementedError
  end
end