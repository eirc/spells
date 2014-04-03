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
      @parser.parse text
    end
  end
end
