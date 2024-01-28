def horizontal_reflection(pattern, allow_smudge = false)
  (1..pattern.count - 1).each do |index|
    top = pattern[...index].reverse
    bottom = pattern[index..]

    top = top[...bottom.count]
    bottom = bottom[...top.count]

    return index if top == bottom && !allow_smudge
    
    if allow_smudge
      smudges = top.each_with_index.map do |row, index|
        row.chars.each_with_index.map do |char, char_index|
          char != bottom[index].chars[char_index] ? 1 : 0
        end.sum
      end.sum

      return index if smudges == 1
    end
  end
  0
end

def vertical_reflection(pattern, allow_smudge = false)
  pattern = pattern.map(&:chars).transpose.map(&:join)

  horizontal_reflection(pattern, allow_smudge)
end

puts "Input file path? "
input_file_path = gets.chomp

input = File.read(input_file_path).split(/^\n/)

# part 1

result = input.map do |pattern|
  pattern = pattern.split("\n")

  result = vertical_reflection(pattern) + 100 * horizontal_reflection(pattern)
  result
end.sum

p result

# part 2

result = input.map do |pattern|
  pattern = pattern.split("\n")

  result = vertical_reflection(pattern, true) + 100 * horizontal_reflection(pattern, true)
  result
end.sum

p result