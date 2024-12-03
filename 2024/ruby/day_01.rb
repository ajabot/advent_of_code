puts "Input file path? "
input_file_path = gets.chomp

input = File
  .readlines(input_file_path, chomp: true)
  .reduce({left: [], right: []}) do |lists, line|
    left, right = line.split('   ')
    lists[:left] << left.to_i
    lists[:right] << right.to_i
    lists
  end

left = input[:left].sort
right = input[:right].sort

result = left.each_with_index.map { |number,index| (number - right[index]).abs }.sum
p result

# part 2

result = left.map { |number| number * right.count(number) }.sum
p result