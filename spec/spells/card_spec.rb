require 'spec_helper'

describe Spells::Card do
  context '#abilities' do
    it 'parses activated abilities as abilities' do
      expect(['{T}, Sacrifice a creature: Target player discards a card.',
              '{2}{W}{B}, {T}: Target player discards a card.',
              'Channel - {3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.']).
          to be_parsed_as_abilities ['{T}, Sacrifice a creature: Target player discards a card.',
                                               '{2}{W}{B}, {T}: Target player discards a card.',
                                               '{3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.']
    end

    it 'parses triggered abilities as abilities' do
      expect('Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat.').
          to be_parsed_as_abilities ['Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat.']
    end

    it 'parses activated and triggered abilities as abilities' do
      expect(['{T}, Sacrifice a creature: Target player discards a card.',
              '{2}{W}{B}, {T}: Target player discards a card.',
              'Channel - {3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.',
              'Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat.']).
          to be_parsed_as_abilities ['{T}, Sacrifice a creature: Target player discards a card.',
                                               '{2}{W}{B}, {T}: Target player discards a card.',
                                               '{3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.',
                                               'Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat.']
    end
  end

  context '#activated_abilities' do
    it 'parses an activated ability with a simple mana cost' do
      expect('{B}: Target player discards a card.').
          to be_parsed_as_activated_abilities ['{B}: Target player discards a card.']
    end

    it 'parses an activated ability with a hybrid mana cost' do
      expect('{(u/b)}: Target player discards a card.').
          to be_parsed_as_activated_abilities ['{(u/b)}: Target player discards a card.']
    end

    it 'parses an activated ability with a complex mana cost' do
      expect('{2}{W}{B}{(u/b)}: Target player discards a card.').
          to be_parsed_as_activated_abilities ['{2}{W}{B}{(u/b)}: Target player discards a card.']
    end

    it 'parses an activated ability with a tap cost' do
      expect('{T}: Target player discards a card.').
          to be_parsed_as_activated_abilities ['{T}: Target player discards a card.']
    end

    it 'parses an activated ability with a text cost' do
      expect('Sacrifice a creature: Target player discards a card.').
          to be_parsed_as_activated_abilities ['Sacrifice a creature: Target player discards a card.']
    end

    it 'parses an activated ability with a mana cost and a tap cost' do
      expect('{2}{W}{B}, {T}: Target player discards a card.').
          to be_parsed_as_activated_abilities ['{2}{W}{B}, {T}: Target player discards a card.']
    end

    it 'parses an activated ability with a mana cost and a text cost' do
      expect('{T}, Sacrifice a creature: Target player discards a card.').
          to be_parsed_as_activated_abilities ['{T}, Sacrifice a creature: Target player discards a card.']
    end

    it 'parses an activated ability with an ability word' do
      expect('Channel - {3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.').
          to be_parsed_as_activated_abilities ['{3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.']
    end

    it 'parses an activated ability with a keyword' do
      expect(['Cycling {(u/b)} ({(u/b)}, Discard this card: Draw a card.)']).
          to be_parsed_as_activated_abilities ['{(u/b)}, Discard this card: Draw a card.']
    end

    it 'parses multiple activated abilities' do
      expect(['{T}, Sacrifice a creature: Target player discards a card.',
              '{2}{W}{B}, {T}: Target player discards a card.',
              'Channel - {3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.']).
          to be_parsed_as_activated_abilities ['{T}, Sacrifice a creature: Target player discards a card.',
                                               '{2}{W}{B}, {T}: Target player discards a card.',
                                               '{3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.']
    end

    it 'does not parse triggered abilities as activated' do
      expect('Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat.').
          to be_parsed_as_activated_abilities []
    end

    it 'parses activated abilities when mixed with triggered' do
      expect(['{T}, Sacrifice a creature: Target player discards a card.',
              '{2}{W}{B}, {T}: Target player discards a card.',
              'Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat.',
              'Channel - {3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.']).
          to be_parsed_as_activated_abilities ['{T}, Sacrifice a creature: Target player discards a card.',
                                               '{2}{W}{B}, {T}: Target player discards a card.',
                                               '{3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.']
    end
  end

  context '#triggered_abilities' do
    it 'parses a triggered ability with "Whenever"' do
      expect('Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat.').
          to be_parsed_as_triggered_abilities ['Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat.']
    end

    it 'parses a triggered ability with "At"' do
      expect('At the beginning of your upkeep, you may put a feather counter on target creature.').
          to be_parsed_as_triggered_abilities ['At the beginning of your upkeep, you may put a feather counter on target creature.']
    end

    it 'parses a triggered ability with "When"' do
      expect('When enchanted creature becomes the target of a spell or ability, exile that creature.').
          to be_parsed_as_triggered_abilities ['When enchanted creature becomes the target of a spell or ability, exile that creature.']
    end

    it 'parses a triggered ability with a keyword' do
      expect('Exalted (Whenever a creature you control attacks alone, that creature gets +1/+1 until end of turn.)').
          to be_parsed_as_triggered_abilities ['Whenever a creature you control attacks alone, that creature gets +1/+1 until end of turn.']
    end

    it 'does not parse activated abilities as triggered' do
      expect(['{T}, Sacrifice a creature: Target player discards a card.',
              '{2}{W}{B}, {T}: Target player discards a card.',
              'Channel - {3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.']).
          to be_parsed_as_triggered_abilities []
    end

    it 'parses triggered abilities when mixed with activated' do
      expect(['{T}, Sacrifice a creature: Target player discards a card.',
              '{2}{W}{B}, {T}: Target player discards a card.',
              'Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat.',
              'Channel - {3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.']).
          to be_parsed_as_triggered_abilities ['Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat.']
    end
  end
end
