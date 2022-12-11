if ARGV.empty?
  puts('Please provide day number!')

  exit 0
end

unless File.exist?("#{ARGV.first}/solution.rb")
  puts("Solution #{ARGV.first} not found!")
  exit 0
end

require_relative "#{ARGV.first}/solution.rb"

Solution.new.part_1
Solution.new.part_2