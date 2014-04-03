module Spells
  class ParseNode < Treetop::Runtime::SyntaxNode
    def nodes_of(klass)
      ParseNode.nodes_of klass, self
    end

    def self.nodes_of(klass, tree)
      return if tree.elements.nil?

      tree.
          elements.
          map { |element| element.kind_of?(klass) ? element : nodes_of(klass, element) }.
          flatten.
          compact
    end
  end
end
