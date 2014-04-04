require 'spec_helper'

describe Spells::Card do
  context '#abilities' do
    it 'correctly parses abilities for "Nezumi Bone-Reader"' do
      expect(build(:nezumi_bone_reader).abilities.map { |ability| ability.text_value }).
          to eq([
                    '{B}, Sacrifice a creature: Target player discards a card. Activate this ability only any time you could cast a sorcery.'
                ])
    end

    it 'correctly parses abilities for "Squallmonger"' do
      expect(build(:squallmonger).abilities.map { |ability| ability.text_value }).
          to eq([
                    '{2}: Squallmonger deals 1 damage to each creature with flying and each player. Any player may activate this ability.'
                ])
    end

    it 'correctly parses abilities for "Ghost-Lit Raider"' do
      expect(build(:ghost_lit_raider).abilities.map { |ability| ability.text_value }).
          to eq([
                    '{2}{R}, {T}: Ghost-Lit Raider deals 2 damage to target creature.',
                    'Channel - {3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.'
                ])
    end

    it 'correctly parses abilities for "Abomination"' do
      expect(build(:abomination).abilities.map { |ability| ability.text_value }).
          to eq([
                    'Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat.'
                ])
    end
  end

  context '#activated_abilities' do
    it 'correctly parses activated abilities for "Nezumi Bone-Reader"' do
      expect(build(:nezumi_bone_reader).activated_abilities.map { |ability| ability.text_value }).
          to eq([
                    '{B}, Sacrifice a creature: Target player discards a card. Activate this ability only any time you could cast a sorcery.'
                ])
    end

    it 'correctly parses activated abilities for "Squallmonger"' do
      expect(build(:squallmonger).activated_abilities.map { |ability| ability.text_value }).
          to eq([
                    '{2}: Squallmonger deals 1 damage to each creature with flying and each player. Any player may activate this ability.'
                ])
    end

    it 'correctly parses activated abilities for "Ghost-Lit Raider"' do
      expect(build(:ghost_lit_raider).activated_abilities.map { |ability| ability.text_value }).
          to eq([
                    '{2}{R}, {T}: Ghost-Lit Raider deals 2 damage to target creature.',
                    'Channel - {3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.'
                ])
    end

    it 'correctly parses activated abilities for "Abomination"' do
      expect(build(:abomination).activated_abilities.map { |ability| ability.text_value }).
          to eq([])
    end
  end

  context '#triggered_abilities' do
    it 'correctly parses triggered abilities for "Nezumi Bone-Reader"' do
      expect(build(:squallmonger).triggered_abilities.map { |ability| ability.text_value }).
          to eq([])
    end

    it 'correctly parses triggered abilities for "Ghost-Lit Raider"' do
      expect(build(:ghost_lit_raider).triggered_abilities.map { |ability| ability.text_value }).
          to eq([])
    end

    it 'correctly parses triggered abilities for "Ghost-Lit Raider"' do
      expect(build(:ghost_lit_raider).triggered_abilities.map { |ability| ability.text_value }).
          to eq([])
    end

    it 'correctly parses triggered abilities for "Abomination"' do
      expect(build(:abomination).triggered_abilities.map { |ability| ability.text_value }).
          to eq([
                    'Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat.'
                ])
    end
  end
end
