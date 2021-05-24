require 'rspec'
require_relative '../lib/combo'

RSpec.describe Combo do
  context 'beginner difficulty level' do
    it 'initializes' do
      combo1 = Combo.new

      expect(combo1).to be_an_instance_of(Combo)
      expect(combo1.difficulty_level).to eq(:b)
      expect(combo1.difficulties[combo1.difficulty_level][:colors]).to eq(["r", "g", "b", "y"])
      expect(combo1.mixer).to be_an_instance_of(String)
      expect(combo1.mixer.length).to eq(4)

      combo2 = Combo.new('b')
      expect(combo2.difficulty_level).to eq(:b)
      expect(combo2.difficulties[combo2.difficulty_level][:colors]).to eq(["r", "g", "b", "y"])
      expect(combo2.mixer).to be_an_instance_of(String)
      expect(combo2.mixer.length).to eq(4)

      expect(combo2.difficulties[combo2.difficulty_level][:num_chars]).to eq(4)
      expect(combo2.difficulties[combo2.difficulty_level][:start_message]).to eq(
        [
          'I have generated a beginner sequence with four elements made up of:',
          '(r)ed, (g)reen, (b)lue, and (y)ellow.'
        ])
      expect(combo2.difficulties[combo2.difficulty_level][:start_message]).to be_an_instance_of(Array)
    end
  end

  context 'intermediate difficulty level' do
    it 'initializes' do
      combo = Combo.new('intermediate')

      expect(combo).to be_an_instance_of(Combo)
      expect(combo.difficulty_level).to eq(:i)
      expect(combo.difficulties[combo.difficulty_level][:colors]).to eq(["r", "g", "b", "y", "p"])
      expect(combo.mixer).to be_an_instance_of(String)
      expect(combo.mixer.length).to eq(6)

      expect(combo.difficulties[combo.difficulty_level][:num_chars]).to eq(6)
      expect(combo.difficulties[combo.difficulty_level][:start_message]).to eq(
        [
          'I have generated an intermediate sequence with six elements made up of:',
          '(r)ed, (g)reen, (b)lue, (y)ellow, and (p)ink.'
        ])
      expect(combo.difficulties[combo.difficulty_level][:start_message]).to be_an_instance_of(Array)
    end
  end

  context 'advanced difficulty level' do
    it 'initializes' do
      combo = Combo.new('ADVANCEDDDDDDD')

      expect(combo).to be_an_instance_of(Combo)
      expect(combo.difficulty_level).to eq(:a)
      expect(combo.difficulties[combo.difficulty_level][:colors]).to eq(["r", "g", "b", "y", "p", "o"])
      expect(combo.mixer).to be_an_instance_of(String)
      expect(combo.mixer.length).to eq(8)

      expect(combo.difficulties[combo.difficulty_level][:num_chars]).to eq(8)
      expect(combo.difficulties[combo.difficulty_level][:start_message]).to eq(
        [
          'I have generated an advanced sequence with eight elements made up of:',
          '(r)ed, (g)reen, (b)lue, (y)ellow, (p)ink, and (o)range.'
        ])
      expect(combo.difficulties[combo.difficulty_level][:start_message]).to be_an_instance_of(Array)
    end
  end
end
