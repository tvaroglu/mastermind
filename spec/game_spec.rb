require 'rspec'
require_relative 'spec_helper'

RSpec.describe Game do
  it 'initializes' do
    game = Game.new
    expect(game.class).to eq(Game)

    expected = [
      'Welcome to MASTERMIND',
      'Would you like to (p)lay, read the (i)nstructions, or (q)uit?',
      ' >'
    ]
    expect(game.welcome_message).to eq(expected)
    expect(game.print_welcome).to eq(game.welcome_message)

    expected = [
      'You will be presented with a sequence of colors.',
      'There are four possible colors (red, green, blue, and yellow).',
      'Each color is represented by the first letter (i.e. "r" = "red").',
      'Guess the correct four color combination to win the game (i.e. "yrbg").',
      'Colors can repeat, and every color does not have to be used.',
      'Intermediate and Advanced difficulty levels will have longer and more complex sequences.',
      'Good luck!',
      '-'*30,
      'Press "Enter" to continue.',
      ' >'
    ]
    expect(game.instructions).to eq(expected)

    expected = [
      '',
      '',
      'Use (q)uit at any time to end the game.',
      "What's your guess?",
      ' >'
    ]
    expect(game.start_message).to eq(expected)

    expect(game.guess_counter).to eq(0)
    expect(game.starting_time).to eq(0)
    expect(game.ending_time).to eq(0)
    expect(game.singular_vs_plural).to eq('guess')
    expect(game.difficulty_level).to eq(:b)
    expect(game.winning_sequence).to eq('')
  end

  it 'can print the start messages for each difficulty level' do
    game = Game.new
    expected = [
      'I have generated a beginner sequence with four elements made up of:',
      '(r)ed, (g)reen, (b)lue, and (y)ellow.',
      'Use (q)uit at any time to end the game.',
      "What's your guess?",
      ' >'
    ]
    expect(game.print_start).to eq(expected)

    game.instance_variable_set(:@difficulty_level, :i)
    expected = [
      'I have generated an intermediate sequence with six elements made up of:',
      '(r)ed, (g)reen, (b)lue, (y)ellow, and (p)ink.',
      'Use (q)uit at any time to end the game.',
      "What's your guess?",
      ' >'
    ]
    expect(game.print_start).to eq(expected)

    game.instance_variable_set(:@difficulty_level, :a)
    expected = [
      'I have generated an advanced sequence with eight elements made up of:',
      '(r)ed, (g)reen, (b)lue, (y)ellow, (p)ink, and (o)range.',
      'Use (q)uit at any time to end the game.',
      "What's your guess?",
      ' >'
    ]
    expect(game.print_start).to eq(expected)
  end

  it 'can select all difficulty levels' do
    game = Game.new
    allow($stdin).to receive(:gets).and_return('b')

    game.select_difficulty
    expect(game.difficulty_level).to eq(:b)

    allow($stdin).to receive(:gets).and_return('BEGINNER')

    game.select_difficulty
    expect(game.difficulty_level).to eq(:b)

    allow($stdin).to receive(:gets).and_return('')

    game.select_difficulty
    expect(game.difficulty_level).to eq(:b)

    allow($stdin).to receive(:gets).and_return('i')

    game.select_difficulty
    expect(game.difficulty_level).to eq(:i)

    allow($stdin).to receive(:gets).and_return('a')

    game.select_difficulty
    expect(game.difficulty_level).to eq(:a)
  end

  it 'can increment and reset guess counts' do
    game = Game.new
    expect(game.guess_counter).to eq(0)
    expect(game.singular_vs_plural).to eq('guess')

    game.instance_variable_set(:@singular_vs_plural, 'guesses')

    2.times { game.increment_guesses }
    expect(game.guess_counter).to eq(2)
    expect(game.singular_vs_plural).to eq('guesses')

    game.reset_guesses

    expect(game.guess_counter).to eq(0)
    expect(game.singular_vs_plural).to eq('guess')
  end

  it 'can evaluate user guesses and cheats' do
    game = Game.new

    expect(game.try_again('c')).to eq("You've taken 0 guesses.\n >")
    expect(game.try_again('brrb')).to eq("You've taken 1 guess.\n >")
    expect(game.try_again('brrb')).to eq("You've taken 2 guesses.\n >")
  end

  it 'can return total elapsed game time' do
    game = Game.new
    expect(game.starting_time).to eq(0)
    expect(game.ending_time).to eq(0)

    game.instance_variable_set(:@starting_time, 86280.643211)
    game.instance_variable_set(:@ending_time, 86342.580943)

    expect(game.timer).to eq("1 minute(s) 2 second(s)")
  end


end
