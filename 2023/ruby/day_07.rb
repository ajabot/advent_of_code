puts "Input file path? "
input_file_path = gets.chomp

hands = File.readlines(input_file_path).map(&:split)

WININNING_HANDS = {
  five_of_kind: 7,
  four_of_kind: 6,
  full_house: 5,
  three_of_kind: 4,
  two_pair: 3,
  one_pair: 2,
  high_card: 1,
}

CARD_STRENGTH = {
  'A' => 12,
  'K' => 11,
  'Q' => 10,
  'J' => 9,
  'T' => 8,
  '9' => 7,
  '8' => 6,
  '7' => 5,
  '6' => 4,
  '5' => 3,
  '4' => 2,
  '3' => 1,
  '2' => 0
}

CARD_JOKERS_STRENGTH = {
  'A' => 12,
  'K' => 11,
  'Q' => 10,
  'T' => 9,
  '9' => 8,
  '8' => 7,
  '7' => 6,
  '6' => 5,
  '5' => 4,
  '4' => 3,
  '3' => 2,
  '2' => 1,
  'J' => 0,
}

def parse_hand(hand, jokers = false)
  tally = if !jokers
    hand.tally
  else
    tally = hand.tally
    jokers = tally.delete("J") || 0
    key = tally.key(tally.values.max)
    if key.nil?
      tally["J"] = jokers
    else
      tally[key] = tally[key] + jokers
    end
    tally
  end

  case tally.values.sort
  when [5]
    :five_of_kind
  when [1, 4]
    :four_of_kind
  when [2, 3]
    :full_house
  when [1, 1, 3]
    :three_of_kind
  when [1, 2, 2]
    :two_pair
  when [1, 1, 1, 2]
    :one_pair
  when [1, 1, 1, 1, 1]
    :high_card
  else
    raise "unknown hand #{hand.join}"
  end

end

def sort_hands(a, b, jokers = false)
  return -1 if WININNING_HANDS[a["type"]] < WININNING_HANDS[b["type"]]
  return 1 if WININNING_HANDS[a["type"]] > WININNING_HANDS[b["type"]]
  
  strengths = jokers ? CARD_JOKERS_STRENGTH : CARD_STRENGTH

  a["hand"].each_with_index do |card, index|
    return -1 if strengths[card] < strengths[b["hand"][index]]
    return 1 if strengths[card] > strengths[b["hand"][index]]
  end

  0
end

# part 1

parsed_hands = hands.map do |hand|
  hand_chars = hand.first.chars

  {
    "hand" => hand_chars,
    "bid" => hand.last,
    "type" => parse_hand(hand_chars)
  }
end

sorted_hands = parsed_hands.sort { |a,b| sort_hands(a, b)}

result = sorted_hands.each_with_index.reduce(0) do |sum, (hand, index)|
  sum = sum + hand["bid"].to_i * (index + 1)
end

p result

# part 2

parsed_hands = hands.map do |hand|
  hand_chars = hand.first.chars

  {
    "hand" => hand_chars,
    "bid" => hand.last,
    "type" => parse_hand(hand_chars, true)
  }
end

sorted_hands = parsed_hands.sort { |a,b| sort_hands(a, b, true)}

result = sorted_hands.each_with_index.reduce(0) do |sum, (hand, index)|
  sum = sum + hand["bid"].to_i * (index + 1)
end

p result

