# Spells

[![Gem Version](https://badge.fury.io/rb/spells.png)](http://badge.fury.io/rb/spells)
[![Build Status](https://travis-ci.org/eirc/spells.svg?branch=master)](https://travis-ci.org/eirc/spells)
[![Code Climate](https://codeclimate.com/github/eirc/spells.png)](https://codeclimate.com/github/eirc/spells)
[![Dependencies Status](https://gemnasium.com/eirc/spells.png)](https://gemnasium.com/eirc/spells)
[![Coverage Status](https://coveralls.io/repos/eirc/spells/badge.png)](https://coveralls.io/r/eirc/spells)

Spells is a library for parsing the text on Magic: The Gathering cards.

Note that this is pre-pre-Alpha software and you should probably not really use it!

## Installation

Add this line to your application's Gemfile:

    gem 'spells'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spells

## Usage

Parsing activated abilities

```ruby
card = Spells::Card.new
card.text = "{2}{R}, {T}: Ghost-Lit Raider deals 2 damage to target creature.
Channel - {3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature."
card.abilities.map &:text_value
# => ["{2}{R}, {T}: Ghost-Lit Raider deals 2 damage to target creature.", "Channel - {3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature."]
card.triggered_abilities.map &:text_value
# => []
card.activated_abilities.map &:text_value
# => ["{2}{R}, {T}: Ghost-Lit Raider deals 2 damage to target creature.", "Channel - {3}{R}, Discard Ghost-Lit Raider: Ghost-Lit Raider deals 4 damage to target creature."]
```

Parsing triggered abilities

```ruby
card = Spells::Card.new
card.text = "Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat."
card.abilities.map &:text_value
# => ["Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat."]
card.triggered_abilities.map &:text_value
# => ["Whenever Abomination blocks or becomes blocked by a green or white creature, destroy that creature at end of combat."]
card.activated_abilities.map &:text_value
# => []
```

## Development

This gem uses the [treetop](http://treetop.rubyforge.org) gem for declaring the syntax tree. Some resources on treetop:

* http://treetop.rubyforge.org
* http://thingsaaronmade.com/blog/a-quick-intro-to-writing-a-parser-using-treetop.html

## Contributing

1. Fork it ( https://github.com/[my-github-username]/spells/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
