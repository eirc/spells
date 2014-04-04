FactoryGirl.define do
  factory :card, class: Spells::Card do
    name ''
    text ''
  end

  factory :nezumi_bone_reader, class: Spells::Card do
    name 'Nezumi Bone-Reader'
    text '{B}, Sacrifice a creature: Target player discards a card. Activate this ability only any time you could cast a sorcery.'
  end

  factory :squallmonger, class: Spells::Card do
    name 'Squallmonger'
    text '{2}: Squallmonger deals 1 damage to each creature with flying and each player. Any player may activate this ability.'
  end

  factory :ghost_lit_raider, class: Spells::Card do
    name 'Ghost-Lit Raider'
    text '{2}{R}, {T}: Ghost-Lit Raider deals 2 damage to target creature.
Channel - {3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature.'
  end

  factory :abomination, class: Spells::Card do
    name 'Abomination'
    text 'Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat.'
  end
end
