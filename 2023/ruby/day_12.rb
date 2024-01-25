puts "Input file path? "
input_file_path = gets.chomp

input = File.readlines(input_file_path, chomp: true)

def possible_combinations_count(springs, broken_groups, cache = {})
  if  springs.empty?
    return broken_groups.empty? ? 1 : 0
  end

  if broken_groups.empty?
    return springs.index("#") ? 0 : 1
  end
  
  cache_key = "#{springs.join}-#{broken_groups.join("-")}"
  return cache[cache_key] if cache[cache_key]

  result = 0
  
  if  [".", "?"].include?(springs.first)
    result += possible_combinations_count(springs[1..], broken_groups, cache)
  end
  
  if ["#", "?"].include?(springs.first)
    if broken_groups.first <= springs.count &&
      !springs[...(broken_groups.first)].include?(".") &&
      (broken_groups.first == springs.count || springs[broken_groups.first] != "#")
        result += possible_combinations_count(springs[(broken_groups.first + 1)..].to_a, broken_groups[1..].to_a, cache)
    end
  end
  
  cache[cache_key] = result
  result
end

# part 1 
result = input.map do |line|
  springs, broken_groups = line.split(" ")
  broken_groups = line.scan(/\d+/).map(&:to_i)
  possible_combinations_count(springs.chars, broken_groups)
end.sum

p result

# part 1 
result = input.map do |line|
  springs, broken_groups = line.split(" ")
  springs = ([springs] * 5).join("?")
  broken_groups = line.scan(/\d+/).map(&:to_i)
  possible_combinations_count(springs.chars, (broken_groups * 5))
end.sum

p result