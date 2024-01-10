puts "Input file path? "
input_file_path = gets.chomp

input = File.readlines(input_file_path, chomp: true).map(&:chars)

DIRECTION_MAPPING = {
  "N" => {
    "|" => "N",
    "7" => "W",
    "F" => "E",
  },
  "E" => {
    "-" => "E",
    "J" => "N",
    "7" => "S",
  },
  "S" => {
    "|" => "S",
    "L" => "E",
    "J" => "W",
  },
  "W" => {
    "-" => "W",
    "L" => "N",
    "F" => "S",
  },
}

DIRECTION_PIPES_MAPPING = {
  "N" => ["|", "F", "7"],
  "E" => ["-", "J", "7"],
  "s" => ["|", "J", "L"],
  "W" => ["-", "L", "F"]
}

def next_pipe(pipe, direction)
  case direction
  when "N"
    [pipe.first, pipe.last - 1]
  when "E"
    [pipe.first + 1, pipe.last]
  when "S"
    [pipe.first, pipe.last + 1]
  when "W"
    [pipe.first - 1, pipe.last]
  end
end


start_y = input.index { |line| line.include?("S") }
start_x = input[start_y].index("S")

visited = {}
pipe = [start_x, start_y]
direction = "E"

# part 1

while visited[pipe].nil?
  visited[pipe] = true

  pipe = next_pipe(pipe, direction)
  next_pipe_symbol = input[pipe.last][pipe.first]
  direction = DIRECTION_MAPPING[direction][next_pipe_symbol]
end

p visited.count / 2