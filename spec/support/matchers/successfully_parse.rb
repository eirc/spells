RSpec::Matchers.define :successfully_parse do |expected_card|
  match do |parser|
    begin
      parser.parse expected_card.text
      true
    rescue Spells::ParseError => error
      @error = error
      false
    end
  end

  description do
    "successfully parse '#{expected_card.name}'"
  end

  failure_message_for_should do
    "expected parser to successfully parse '#{expected_card.name}', the error was: #{@error.message}"
  end
end
