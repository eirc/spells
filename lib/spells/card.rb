module Spells
  class Card
    attr_accessor :name
    attr_accessor :text

    def abilities
      parsed_text.nodes_of Ability
    end

    def triggered_abilities
      parsed_text.nodes_of TriggeredAbility
    end

    def activated_abilities
      parsed_text.nodes_of ActivatedAbility
    end

    protected

    def parsed_text
      @parsed_text ||= Spells::Parser.instance.parse text
    end
  end
end
