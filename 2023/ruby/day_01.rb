puts "Input file path? "
input_file_path = gets.chomp

# part 1
result = File
  .readlines(input_file_path)
  .map do |line| 
    digits = line.delete('^0-9').chars
  (digits.first + digits.last).to_i
  end
  .sum

puts result

# part 2

replacements = {
  'one' => '1',
  'two' => '2',
  'three' => '3',
  'four' => '4',
  'five' => '5',
  'six' => '6',
  'seven' => '7',
  'eight' => '8',
  'nine' => '9',
}

spelled_regex = /(one|two|three|four|five|six|seven|eight|nine)/
numeric_regex = /[1-9]/

result = File.readlines(input_file_path)
  .map do |line|
    first_digit_index = line.index(numeric_regex)
    first_spelled_number_index = line.index(spelled_regex)
    first_digit = if first_spelled_number_index.nil? || first_digit_index < first_spelled_number_index
      line[first_digit_index]
    else
      line.match(spelled_regex)[1].sub(spelled_regex, replacements)
    end

    last_digit_index = line.rindex(numeric_regex)
    last_spelled_number_index = line.rindex(spelled_regex)
    last_digit = if last_spelled_number_index.nil? || last_digit_index > last_spelled_number_index
      line[last_digit_index]
    else
      line.match(spelled_regex, last_spelled_number_index)[1].sub(spelled_regex, replacements)
    end

    (first_digit + last_digit).to_i
  end
  .sum

puts result