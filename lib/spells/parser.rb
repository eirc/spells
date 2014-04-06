module Spells
  class Parser
    include ::Singleton

    def initialize
      Treetop.load File.expand_path('../../../grammar/spells/punctuation.treetop', __FILE__)
      Treetop.load File.expand_path('../../../grammar/spells/symbols.treetop', __FILE__)
      Treetop.load File.expand_path('../../../grammar/spells.treetop', __FILE__)
      @parser = SpellsParser.new
    end

    def parse(text)
      result = @parser.parse text
      raise ParseError.new("Failed to parse text '#{text}' at index #{@parser.index}") if result.nil?
      result
    end
  end
end
