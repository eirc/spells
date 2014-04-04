require 'spec_helper'

describe Spells::Card do
  context '#abilities' do
    it 'parses activated and triggered abilities as abilities' do
      abilities = ['{T}, Sacrifice a creature: Target player discards a card.',
                   '{2}{W}{B}, {T}: Target player discards a card.',
                   'Channel - {3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.',
                   'Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat.']

      expect(build(:card, text: abilities.join("\n")).abilities.map { |ability| ability.text_value }).to eq(abilities)
    end
  end

  context '#activated_abilities' do
    it 'parses an activated ability with a simple mana cost' do
      abilities = ['{B}: Target player discards a card.']
      expect(build(:card, text: abilities.join("\n")).activated_abilities.map { |ability| ability.text_value }).to eq(abilities)
    end

    it 'parses an activated ability with a complex mana cost' do
      abilities = ['{2}{W}{B}: Target player discards a card.']
      expect(build(:card, text: abilities.join("\n")).activated_abilities.map { |ability| ability.text_value }).to eq(abilities)
    end

    it 'parses an activated ability with a tap cost' do
      abilities = ['{T}: Target player discards a card.']
      expect(build(:card, text: abilities.join("\n")).activated_abilities.map { |ability| ability.text_value }).to eq(abilities)
    end

    it 'parses an activated ability with a text cost' do
      abilities = ['Sacrifice a creature: Target player discards a card.']
      expect(build(:card, text: abilities.join("\n")).activated_abilities.map { |ability| ability.text_value }).to eq(abilities)
    end

    it 'parses an activated ability with a mana cost and a tap cost' do
      abilities = ['{2}{W}{B}, {T}: Target player discards a card.']
      expect(build(:card, text: abilities.join("\n")).activated_abilities.map { |ability| ability.text_value }).to eq(abilities)
    end

    it 'parses an activated ability with a mana cost and a text cost' do
      abilities = ['{T}, Sacrifice a creature: Target player discards a card.']
      expect(build(:card, text: abilities.join("\n")).activated_abilities.map { |ability| ability.text_value }).to eq(abilities)
    end

    it 'parses multiple activated abilities' do
      abilities = ['{T}, Sacrifice a creature: Target player discards a card.',
                   '{2}{W}{B}, {T}: Target player discards a card.',
                   'Channel - {3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.']
      expect(build(:card, text: abilities.join("\n")).activated_abilities.map { |ability| ability.text_value }).to eq(abilities)
    end

    it 'does not parse triggered abilities as activated' do
      abilities = ['Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat.']
      expect(build(:card, text: abilities.join("\n")).activated_abilities.map { |ability| ability.text_value }).to eq([])
    end

    it 'parses activated abilities when mixed with triggered' do
      abilities = ['{T}, Sacrifice a creature: Target player discards a card.',
                   '{2}{W}{B}, {T}: Target player discards a card.',
                   'Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat.',
                   'Channel - {3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.']
      expect(build(:card, text: abilities.join("\n")).activated_abilities.map { |ability| ability.text_value }).to eq([abilities[0], abilities[1], abilities[3]])
    end
  end

  context '#triggered_abilities' do
    it 'parses a triggered ability with "Whenever"' do
      abilities = ['Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat.']
      expect(build(:card, text: abilities.join("\n")).triggered_abilities.map { |ability| ability.text_value }).to eq(abilities)
    end

    it 'does not parse activated abilities as triggered' do
      abilities = ['{T}, Sacrifice a creature: Target player discards a card.',
                   '{2}{W}{B}, {T}: Target player discards a card.',
                   'Channel - {3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.']
      expect(build(:card, text: abilities.join("\n")).triggered_abilities.map { |ability| ability.text_value }).to eq([])
    end

    it 'parses triggered abilities when mixed with activated' do
      abilities = ['{T}, Sacrifice a creature: Target player discards a card.',
                   '{2}{W}{B}, {T}: Target player discards a card.',
                   'Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat.',
                   'Channel - {3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.']
      expect(build(:card, text: abilities.join("\n")).triggered_abilities.map { |ability| ability.text_value }).to eq([abilities[2]])
    end
  end
end
