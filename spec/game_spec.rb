require 'simplecov'
SimpleCov.start

require 'rspec'
require_relative '../lib/game'

RSpec.describe Game do
  context "the user hasn't started guessing yet" do
    before :each do
      @game = Game.new
    end

    it 'initializes' do
      expect(@game).to be_an_instance_of(Game)
      expect(@game.guess_counter).to eq(0)
      expect(@game.starting_time).to eq(0)
      expect(@game.ending_time).to eq(0)
      expect(@game.singular_vs_plural).to eq('guess')
      expect(@game.difficulty_level).to eq(:b)
      expect(@game.winning_sequence).to eq('')
    end

    it 'prints messages' do
      expect(@game.welcome_message.to_s).to include(
        'Welcome', '(p)lay', ' >')
      expect(@game.start_message.to_s).to include(
        '(q)uit', 'your guess?', ' >')
      expect(@game.instructions.to_s).to include(
        'presented', 'four', 'represented', 'combination', 'repeat,', 'difficulty levels', 'luck!', '-', 'Press', ' >')
    end
  end

  context ': the user started guessing' do
    before :each do
      @game = Game.new
      @stubbed_sequence = 'yybr'

      @stubbed_user_guess = 'rbrr'
      @guess = Guess.new(@stubbed_sequence, @stubbed_user_guess)
    end

    xit '. Unskip test for a full run where a user can guess until they win the game or quit' do
      @game.run(@guess)

      expect(@game.winning_sequence).to eq(@stubbed_sequence)
    end
  end
end
