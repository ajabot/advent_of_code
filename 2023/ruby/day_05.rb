puts "Input file path? "
input_file_path = gets.chomp

input = File.read(input_file_path).split(/^\n+/)
seeds = input.shift
seeds = seeds.scan(/\d+/).map(&:to_i)

seed_to_soil, soil_to_fertilizer, fertilizer_to_water, water_to_light,
light_to_temperature, temperature_to_humidity, humidity_to_location = input
  .map do |mappings|
    maps = mappings.split(":\n").last.split("\n")
    maps.map(&:split).map { |mapping| mapping.map(&:to_i) }
  end

# part 1

mappings = [
  seed_to_soil,
  soil_to_fertilizer,
  fertilizer_to_water,
  water_to_light,
  light_to_temperature,
  temperature_to_humidity,
  humidity_to_location
]

locations = seeds
  .reduce([]) do |locations, seed|
    location = mappings.reduce(seed) do |number, maps|
      match = maps.find do |mapping|
        dest, source, range = mapping
        (source..source + range).include?(number)
      end
      
      next number if match.nil?

      dest, source, range = match
      number = dest + (source - number).abs
      number
    end

    locations << location
  end

p locations.min

# part 2

seeds = seeds.each_slice(2).to_a
result = 0
loop.with_index do |_, location|
  soil = mappings
    .reverse
    .reduce(location) do |number, maps|
      match = maps.find do |mapping|
        source, dest, range = mapping
        (source..source + range).include?(number)
      end
      
      next number if match.nil?

      source, dest, range = match
      number = dest + (source - number).abs
      number
    end


  match = seeds.find do |seed|
    (seed.first..seed.first + seed.last).include?(soil)
  end

  unless match.nil?
    result = location
    break
  end
end

p result