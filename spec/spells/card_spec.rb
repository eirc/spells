require 'spec_helper'

describe Spells::Card do

  context '#abilities' do
    it 'successfully parses abilities for all fixtures' do
      card_fixtures.each do |card|
        expect(card.abilities).not_to eq(nil)
        expect(card.abilities).to be_an(Array)
      end
    end

    it 'correctly parses abilities for "Nezumi Bone-Reader"' do
      expect(card_fixture('Nezumi Bone-Reader').abilities.map { |ability| ability.text_value }).
          to eq([
                    '{B}, Sacrifice a creature: Target player discards a card. Activate this ability only any time you could cast a sorcery.'
                ])
    end

    it 'correctly parses abilities for "Squallmonger"' do
      expect(card_fixture('Squallmonger').abilities.map { |ability| ability.text_value }).
          to eq([
                    '{2}: Squallmonger deals 1 damage to each creature with flying and each player. Any player may activate this ability.'
                ])
    end

    it 'correctly parses abilities for "Ghost-Lit Raider"' do
      expect(card_fixture('Ghost-Lit Raider').abilities.map { |ability| ability.text_value }).
          to eq([
                    '{2}{R}, {T}: Ghost-Lit Raider deals 2 damage to target creature.',
                    'Channel - {3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.'
                ])
    end

    it 'correctly parses abilities for "Abomination"' do
      expect(card_fixture('Abomination').abilities.map { |ability| ability.text_value }).
          to eq([
                    'Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat.'
                ])
    end
  end

  context '#activated_abilities' do
    it 'successfully parses activated abilities for all fixtures' do
      card_fixtures.each do |card|
        expect(card.activated_abilities).not_to eq(nil)
        expect(card.activated_abilities).to be_an(Array)
      end
    end

    it 'correctly parses activated abilities for "Nezumi Bone-Reader"' do
      expect(card_fixture('Nezumi Bone-Reader').activated_abilities.map { |ability| ability.text_value }).
          to eq([
                    '{B}, Sacrifice a creature: Target player discards a card. Activate this ability only any time you could cast a sorcery.'
                ])
    end

    it 'correctly parses activated abilities for "Squallmonger"' do
      expect(card_fixture('Squallmonger').activated_abilities.map { |ability| ability.text_value }).
          to eq([
                    '{2}: Squallmonger deals 1 damage to each creature with flying and each player. Any player may activate this ability.'
                ])
    end

    it 'correctly parses activated abilities for "Ghost-Lit Raider"' do
      expect(card_fixture('Ghost-Lit Raider').activated_abilities.map { |ability| ability.text_value }).
          to eq([
                    '{2}{R}, {T}: Ghost-Lit Raider deals 2 damage to target creature.',
                    'Channel - {3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.'
                ])
    end

    it 'correctly parses activated abilities for "Abomination"' do
      expect(card_fixture('Abomination').activated_abilities.map { |ability| ability.text_value }).
          to eq([])
    end
  end

  context '#triggered_abilities' do
    it 'successfully parses triggered abilities for all fixtures' do
      card_fixtures.each do |card|
        expect(card.triggered_abilities).not_to eq(nil)
        expect(card.triggered_abilities).to be_an(Array)
      end
    end

    it 'correctly parses triggered abilities for "Nezumi Bone-Reader"' do
      expect(card_fixture('Nezumi Bone-Reader').triggered_abilities.map { |ability| ability.text_value }).
          to eq([])
    end

    it 'correctly parses triggered abilities for "Ghost-Lit Raider"' do
      expect(card_fixture('Ghost-Lit Raider').triggered_abilities.map { |ability| ability.text_value }).
          to eq([])
    end

    it 'correctly parses triggered abilities for "Ghost-Lit Raider"' do
      expect(card_fixture('Ghost-Lit Raider').triggered_abilities.map { |ability| ability.text_value }).
          to eq([])
    end

    it 'correctly parses triggered abilities for "Abomination"' do
      expect(card_fixture('Abomination').triggered_abilities.map { |ability| ability.text_value }).
          to eq([
                    'Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat.'
                ])
    end
  end
end
