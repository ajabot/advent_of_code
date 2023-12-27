puts "Input file path? "
input_file_path = gets.chomp

instructions, mappings = File.read(input_file_path).split(/^\n+/)

instructions = instructions.chomp.chars

mappings = mappings
  .split("\n")
  .reduce({}) do |hash, mapping|
    key, left, right = mapping.scan(/[A-Z0-9]{3}/)
    hash[key] = [left, right]
    hash
  end

instructions_size = instructions.count

# part 1

position = "AAA"

counter = 0

loop do
  instruction = instructions[counter % instructions_size]
  position = if instruction == "L"
    mappings[position].first
  else
    mappings[position].last
  end

  break if position == "ZZZ"

  counter = counter + 1
end

p counter + 1

# part 2

positions = mappings.keys.select { |key| key.end_with?('A') }

steps = positions.map do |position|
  counter = 0

  loop do
    instruction = instructions[counter % instructions_size]
    position = if instruction == "L"
      mappings[position].first
    else
      mappings[position].last
    end

    break if position.end_with?('Z')

    counter = counter + 1
  end

  counter + 1
end

p steps.reduce(&:lcm)
