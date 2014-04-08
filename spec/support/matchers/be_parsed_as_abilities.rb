RSpec::Matchers.define :be_parsed_as_abilities do |expected|
  match do |card_text|
    card_text = card_text.join("\n") if card_text.is_a? Array

    card = build :card, text: card_text
    actual = card.abilities.map &:to_s

    @match_array = RSpec::Matchers::BuiltIn::MatchArray.new(expected)
    @match_array.matches? actual
  end

  failure_message_for_should do
    @match_array.failure_message_for_should
  end

  failure_message_for_should_not do
    @match_array.failure_message_for_should_not
  end

  description do
    @match_array.description
  end
end
