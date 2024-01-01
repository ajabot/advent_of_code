puts "Input file path? "
input_file_path = gets.chomp

# part 1

extrapolated_values = File
  .readlines(input_file_path, chomp: true)
  .map do |line|
    sequences = [line.scan(/\-?\d+/).map(&:to_i)]

    while !sequences.last.all?(&:zero?)
      last_sequence = sequences.last
      new_sequence = []
      (1..last_sequence.count - 1).each do |index|
        new_sequence << (last_sequence[index] - last_sequence[index - 1])
      end
      new_sequence = new_sequence.empty? ? [0] : new_sequence
      sequences << new_sequence
    end

    sequences.reverse.reduce(0) do |value, sequence|
      next value if sequence.last == 0
      sequence.last + value
    end 
  end

p extrapolated_values.sum

# part 2

extrapolated_values = File
  .readlines(input_file_path, chomp: true)
  .map do |line|
    sequences = [line.scan(/\-?\d+/).map(&:to_i)]

    while !sequences.last.all?(&:zero?)
      last_sequence = sequences.last
      new_sequence = []
      (1..last_sequence.count - 1).each do |index|
        new_sequence << (last_sequence[index] - last_sequence[index - 1])
      end
      new_sequence = new_sequence.empty? ? [0] : new_sequence
      sequences << new_sequence
    end

    
    sequences.reverse.reduce(0) do |value, sequence|
      sequence.first - value
    end 
  end

p extrapolated_values.sum