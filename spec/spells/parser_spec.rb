require 'spec_helper'

describe Spells::Parser do
  describe '#parse' do
    card_fixtures.each do |card|
      it "successfully parses fixture card '#{card.name}'" do
        expect(Spells::Parser.instance.parse(card.text)).not_to eq(nil)
      end
    end
  end
end
