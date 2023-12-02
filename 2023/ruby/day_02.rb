puts "Input file path? "
input_file_path = gets.chomp

cubes_limits = {
  'red' => 12,
  'green' => 13,
  'blue' => 14,
}

# part 1

result = File
  .readlines(input_file_path)
  .reduce(0) do |sum, game|
    game_id = game[/\d+/].to_i
    
    draws = game.strip.split(': ').last.split('; ')
    impossible_game = draws.any? do |draw|
      draw.split(', ').any? do |colour_count|
        count, colour = colour_count.split
        count.to_i > cubes_limits[colour]
      end
    end

    sum = sum + game_id unless impossible_game
    sum
  end

puts result

# part 2

result = File
  .readlines(input_file_path)
  .reduce(0) do |sum, game|
    game_id = game[/\d+/].to_i
    
    minimum_sets = {
      'red' => 0,
      'green' => 0,
      'blue' => 0,
    }

    draws = game.strip.split(': ').last.split('; ')
    draws.each do |draw|
      draw.split(', ').each do |colour_count|
        count, colour = colour_count.split
        minimum_sets[colour] = count.to_i if count.to_i > minimum_sets[colour]
      end
    end

    sum = sum + minimum_sets.values.inject(:*)
    sum
  end

puts result