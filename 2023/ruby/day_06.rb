# puts "Input file path? "
# input_file_path = gets.chomp

input_file_path = "06.txt"

# part 1

times, records = File.readlines(input_file_path).map { |input_line| input_line.scan(/\d+/).map(&:to_i) }

input = times.zip(records)
victories = input.reduce([]) do |victories, race|
  time, record = race
  victories << (1...time).filter do |charge|
    (time - charge) * charge > record
  end.count
end

p victories.inject(&:*)

# part 2

time, record = File.readlines(input_file_path).map { |input_line| input_line.delete('^0-9').to_i }

victories = []
victories << (1...time).filter do |charge|
  (time - charge) * charge > record
end.count

p victories.inject(&:*)