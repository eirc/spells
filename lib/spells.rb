require 'treetop'
require 'singleton'

require 'spells/version'

module Spells
  autoload :Parser,           'spells/parser'
  autoload :ParseNode,        'spells/parse_node'

  autoload :Card,             'spells/card'
  autoload :Ability,          'spells/ability'
  autoload :ActivatedAbility, 'spells/activated_ability'
  autoload :TriggeredAbility, 'spells/triggered_ability'

  autoload :ParseError,       'spells/errors'
end
