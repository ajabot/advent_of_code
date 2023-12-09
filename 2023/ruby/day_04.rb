puts "Input file path? "
input_file_path = gets.chomp

# part 1
result = File
  .readlines(input_file_path, chomp: true)
	.reduce(0) do |sum, card|
		card_numbers = card.split(': ').last
		winning_numbers, numbers = card_numbers.split(" | ").map(&:split)

		matches = winning_numbers & numbers
		next sum if matches.empty?
		
		sum = sum + (2 ** (matches.count - 1))
	end

puts result

# part 2


cards = File
  .readlines(input_file_path, chomp: true)
	.each_with_index.reduce(Hash.new(0)) do |cards, (card, card_index)|
		cards[card_index] = cards[card_index] + 1
		card_numbers = card.split(': ').last
		winning_numbers, numbers = card_numbers.split(" | ").map(&:split)

		matches = winning_numbers & numbers
		next cards if matches.empty?
		
	  (1..matches.count).each do |i|
			cards[card_index + i] = cards[card_index + i] + cards[card_index] 
		end

		cards
	end

puts cards.values.sum