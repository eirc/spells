$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'spells'

require 'yaml'

def card_fixtures
  @cards ||= YAML.load_file File.expand_path('../../fixtures/cards.yml', __FILE__)
end

def card_fixture(name)
  card_fixtures.find { |card| card.name == name }
end
