require 'spec_helper'

describe Spells::Card do
  context 'with gatherer fixtures' do
    it 'parses master sets file' do
      expect(gatherer_sets).to have_at_least(1).item
    end

    gatherer_sets.each do |set_name|
      context set_name do
        gatherer_set(set_name).each do |card|
          it "successfully parses '#{card.name}'" do
            expect { card.abilities }.not_to raise_error
          end
        end
      end
    end
  end
end
