require 'rspec'
require_relative '../lib/game'

RSpec.describe Game do
  context "the user hasn't played yet" do
    before :each do
      @game = Game.new
    end

    it 'initializes' do
      expect(@game).to be_an_instance_of(Game)
      expect(@game.guess_counter).to eq(0)
      expect(@game.starting_time).to eq(0)
      expect(@game.ending_time).to eq(0)
      expect(@game.singular_vs_plural).to eq('guess')
      expect(@game.winning_sequence).to eq('')
    end

    it 'prints messages' do
      puts "\n"
      expect(@game.print_welcome.to_s).to include('Welcome', '(p)lay', ' >')
      puts "\n"
      puts '~'*50
      expect(@game.print_start.to_s).to include('generated', '(b)lue', '(q)uit', 'your guess?')
      puts "\n"
      puts '~'*50
      expect(@game.print_instructions.to_s).to include('presented', 'four', 'represented', 'combination', 'repeat,', 'luck!', '-', 'press', ' >')
      puts "\n"
      puts '~'*50
    end
  end

  context 'the user started playing' do
    before :each do
      @game = Game.new
      @stubbed_sequence = 'yybr'

      @stubbed_user_guess = 'rbrr'
      @guess = Guess.new(@stubbed_sequence, @stubbed_user_guess)
    end

    it 'can run when a user guesses until they win the game' do
      @game.run(@guess)

      expect(@game.winning_sequence).to eq(@stubbed_sequence)
    end
  end
end
