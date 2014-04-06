require 'yaml'

#def gatherer_card_fixtures
#  @cards ||= YAML.load_file File.expand_path('../../fixtures/cards.yml', __FILE__)
#end

def gatherer_sets
  filename = File.expand_path("../../fixtures/gatherer/sets.yml", __FILE__)
  YAML.load_file filename
end

def gatherer_set(set_name)
  basename = set_name.gsub(/\W/, '_').squeeze('_').downcase
  filename = File.expand_path("../../fixtures/gatherer/set-#{basename}.yml", __FILE__)
  YAML.load_file filename
end

def gatherer_card(set_name, card_name)
  gatherer_set(set_name).find { |card| card.name == card_name }
end
