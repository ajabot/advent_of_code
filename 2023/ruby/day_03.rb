puts "Input file path? "
input_file_path = gets.chomp

input = File.readlines(input_file_path, chomp: true)


def symbol?(char)
	return false if char.nil?
	return false if char == '.' || char =~ /\d/
	true
end

def digit?(char)
	return true if char =~ /\d/
	false
end

def fetch_number(x, y, input)
	number = input[y][x]

	left_index = x - 1
	while digit?(input[y][left_index])
		number = input[y][left_index] + number
		left_index = left_index - 1	
	end

	right_index = x + 1
	while digit?(input[y][right_index])
		number = number + input[y][right_index]
		right_index = right_index	+ 1	
	end

	number.to_i
end

# part 1

sum = input.each_with_index.reduce(0) do |sum, (line, line_index)|
	line_numbers = line.scan(/\d+/)
	next sum if line_numbers.empty?
	
	max_x = 0

	line_numbers.each do |number|
		number_index = line.index(number, max_x)
		min_x = number_index == 0 ? 0 : number_index - 1
		max_x = number_index + number.size
		
		if symbol?(line[min_x]) || symbol?(line[max_x])
			sum = sum + number.to_i
			next
		end

		if line_index > 0
			if (min_x..max_x).to_a.any? { |index| symbol?(input[line_index - 1][index]) }
				sum = sum + number.to_i
				next
			end
		end

		next if line_index == input.count - 1
		sum = sum + number.to_i if (min_x..max_x).to_a.any? { |index| symbol?(input[line_index + 1][index]) } 
  end
	sum
end

puts sum

# part 2

sum = input.each_with_index.reduce(0) do |sum, (line, line_index)|
	gear_symbols = line.scan("*")
	next sum if gear_symbols.empty?
	
	max_x = 0

	gear_symbols.each do |gear_symbol|
		numbers_neighbours = []

		symbol_index = line.index(gear_symbol, max_x)
		min_x = symbol_index == 0 ? 0 : symbol_index - 1
		max_x = symbol_index + 1
		
		numbers_neighbours << fetch_number(min_x, line_index, input) if digit?(line[min_x])
		numbers_neighbours << fetch_number(max_x, line_index, input) if digit?(line[max_x])

		if line_index > 0
			(min_x..max_x).to_a.each do |index|
				if digit?(input[line_index - 1][index])
					numbers_neighbours << fetch_number(index, line_index - 1, input)
					# if the middle character is a number there can't be 2 numbers adjacent to the gear on that line
					break if digit?(input[line_index - 1][index + 1])
				end
			end
		end

		
		if line_index != input.count - 1
			(min_x..max_x).to_a.each do |index|
				if digit?(input[line_index + 1][index])
					numbers_neighbours << fetch_number(index, line_index + 1, input)
					# if the middle character is a number there can't be 2 numbers adjacent to the gear on that line
					break if digit?(input[line_index + 1][index + 1])
				end
			end
		end

		if numbers_neighbours.count == 2
			sum = sum + numbers_neighbours.inject(:*)
		end
  end
	sum
end

puts sum