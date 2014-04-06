require 'spec_helper'

describe Spells::Card do
  context '#abilities' do
    it 'parses activated abilities as abilities' do
      abilities = ['{T}, Sacrifice a creature: Target player discards a card.',
                   '{2}{W}{B}, {T}: Target player discards a card.',
                   'Channel - {3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.']

      expect(build(:card, text: abilities.join("\n")).abilities.map { |ability| ability.to_s }).
          to match_array(abilities)
    end

    it 'parses triggered abilities as abilities' do
      abilities = ['Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat.']

      expect(build(:card, text: abilities.join("\n")).abilities.map { |ability| ability.to_s }).
          to match_array(abilities)
    end

    it 'parses activated and triggered abilities as abilities' do
      abilities = ['{T}, Sacrifice a creature: Target player discards a card.',
                   '{2}{W}{B}, {T}: Target player discards a card.',
                   'Channel - {3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.',
                   'Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat.']

      expect(build(:card, text: abilities.join("\n")).abilities.map { |ability| ability.to_s }).
          to match_array(abilities)
    end
  end

  context '#activated_abilities' do
    it 'parses an activated ability with a simple mana cost' do
      abilities = ['{B}: Target player discards a card.']
      expect(build(:card, text: abilities.join("\n")).activated_abilities.map { |ability| ability.to_s }).
          to match_array(abilities)
    end

    it 'parses an activated ability with a complex mana cost' do
      abilities = ['{2}{W}{B}: Target player discards a card.']
      expect(build(:card, text: abilities.join("\n")).activated_abilities.map { |ability| ability.to_s }).
          to match_array(abilities)
    end

    it 'parses an activated ability with a tap cost' do
      abilities = ['{T}: Target player discards a card.']
      expect(build(:card, text: abilities.join("\n")).activated_abilities.map { |ability| ability.to_s }).
          to match_array(abilities)
    end

    it 'parses an activated ability with a text cost' do
      abilities = ['Sacrifice a creature: Target player discards a card.']
      expect(build(:card, text: abilities.join("\n")).activated_abilities.map { |ability| ability.to_s }).
          to match_array(abilities)
    end

    it 'parses an activated ability with a mana cost and a tap cost' do
      abilities = ['{2}{W}{B}, {T}: Target player discards a card.']
      expect(build(:card, text: abilities.join("\n")).activated_abilities.map { |ability| ability.to_s }).
          to match_array(abilities)
    end

    it 'parses an activated ability with a mana cost and a text cost' do
      abilities = ['{T}, Sacrifice a creature: Target player discards a card.']
      expect(build(:card, text: abilities.join("\n")).activated_abilities.map { |ability| ability.to_s }).
          to match_array(abilities)
    end

    it 'parses an activated ability with an ability word', focus: true do
      abilities = ['Channel - {3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.']
      expect(build(:card, text: abilities.join("\n")).activated_abilities.map { |ability| ability.to_s }).
          to match_array(abilities)
    end

    it 'parses multiple activated abilities' do
      abilities = ['{T}, Sacrifice a creature: Target player discards a card.',
                   '{2}{W}{B}, {T}: Target player discards a card.',
                   'Channel - {3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.']
      expect(build(:card, text: abilities.join("\n")).activated_abilities.map { |ability| ability.to_s }).
          to match_array(abilities)
    end

    it 'does not parse triggered abilities as activated' do
      abilities = ['Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat.']
      expect(build(:card, text: abilities.join("\n")).activated_abilities.map { |ability| ability.to_s }).
          to match_array([])
    end

    it 'parses activated abilities when mixed with triggered' do
      abilities = ['{T}, Sacrifice a creature: Target player discards a card.',
                   '{2}{W}{B}, {T}: Target player discards a card.',
                   'Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat.',
                   'Channel - {3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.']
      expect(build(:card, text: abilities.join("\n")).activated_abilities.map { |ability| ability.to_s }).
          to match_array([abilities[0], abilities[1], abilities[3]])
    end
  end

  context '#triggered_abilities' do
    it 'parses a triggered ability with "Whenever"' do
      abilities = ['Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat.']
      expect(build(:card, text: abilities.join("\n")).triggered_abilities.map { |ability| ability.to_s }).
          to match_array(abilities)
    end

    it 'parses a triggered ability with "At"' do
      abilities = ['At the beginning of your upkeep, you may put a feather counter on target creature.']
      expect(build(:card, text: abilities.join("\n")).triggered_abilities.map { |ability| ability.to_s }).
          to match_array(abilities)
    end

    it 'parses a triggered ability with "When"' do
      abilities = ['When enchanted creature becomes the target of a spell or ability, exile that creature.']
      expect(build(:card, text: abilities.join("\n")).triggered_abilities.map { |ability| ability.to_s }).
          to match_array(abilities)
    end

    it 'does not parse activated abilities as triggered' do
      abilities = ['{T}, Sacrifice a creature: Target player discards a card.',
                   '{2}{W}{B}, {T}: Target player discards a card.',
                   'Channel - {3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.']
      expect(build(:card, text: abilities.join("\n")).triggered_abilities.map { |ability| ability.to_s }).
          to match_array([])
    end

    it 'parses triggered abilities when mixed with activated' do
      abilities = ['{T}, Sacrifice a creature: Target player discards a card.',
                   '{2}{W}{B}, {T}: Target player discards a card.',
                   'Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat.',
                   'Channel - {3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.']
      expect(build(:card, text: abilities.join("\n")).triggered_abilities.map { |ability| ability.to_s }).
          to match_array([abilities[2]])
    end
  end
end
