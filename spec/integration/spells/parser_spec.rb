require 'spec_helper'

describe Spells::Parser do
  subject { Spells::Parser.instance }

  gatherer_sets.each do |set_name|
    context "for set #{set_name}" do
      gatherer_set(set_name).each do |card|
        it { expect(subject).to successfully_parse(card) }
      end
    end
  end
end
