require 'spec_helper'

describe Spells::Parser do
  describe '#parse' do
    it 'successfully parses all factory cards' do
      [:nezumi_bone_reader, :squallmonger, :ghost_lit_raider, :abomination].each do |factory|
        card = build(factory)
        expect(Spells::Parser.instance.parse(card.text)).not_to eq(nil)
      end
    end
  end
end
