puts "Input file path? "
input_file_path = gets.chomp

input = File.readlines(input_file_path, chomp: true).map(&:chars)

def shortest_distance_sum(universe, expansion_size)
  galaxies = universe.each_with_index.reduce([]) do |points, (line, line_index)|
    line
      .each_index
      .select { |index| line[index] == "#"}
      .each { |index| points << [index, line_index] }
    points
  end
  
  expanded_columns = universe.each_with_index.reduce([]) do |rows, (line, line_index)|
    rows << line_index if line.index('#').nil?
    rows
  end
  
  expanded_rows = universe
    .transpose
    .each_with_index
    .reduce([]) do |columns, (column, column_index)|
      columns << column_index if column.index('#').nil?
      columns
    end
  
  galaxies
    .combination(2)
    .to_a
    .map do |pair|
      p1, p2 = pair
      x_range = [p1.first, p2.first]
      y_range = [p1.last, p2.last]
      expansion_factor = expansion_size > 1 ? expansion_size - 1 : 1
      x_expansion = expanded_rows.count { |row| row > x_range.min && row < x_range.max } * expansion_factor
      y_expansion = expanded_columns.count { |column| column > y_range.min && column < y_range.max } * expansion_factor
      (p2.first - p1.first).abs + (p2.last - p1.last).abs + x_expansion + y_expansion
    end
    .sum
end

p shortest_distance_sum(input, 1)
p shortest_distance_sum(input, 1000000)