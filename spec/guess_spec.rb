require 'rspec'
require_relative '../lib/combo'
require_relative '../lib/guess'

RSpec.describe Guess do
  it "initializes" do

    user_input = "bbyy"
    guess = Guess.new(Combo.new.mixer, user_input)

    expect(guess).to be_an_instance_of(Guess)

    expect(guess.user_guess).to eq("bbyy")
    expect(guess.user_guess).to be_an_instance_of(String)
    expect(guess.user_guess.length).to eq(4)
    expect(guess.user_guess.length).to eq(guess.guess_array.length)
    expect(guess.guess_array).to be_an_instance_of(Array)
    expect(guess.guess_array.length).to eq(4)

    expect(guess.combo_to_guess).to be_an_instance_of(String)
    expect(guess.combo_to_guess.length).to eq(4)
    expect(guess.combo_to_guess.length).to eq(guess.combo_array.length)
    expect(guess.combo_array).to be_an_instance_of(Array)
    expect(guess.combo_array.length).to eq(4)
  end

  it "evaluates user input" do
    puts "\n"
    stubbed_combo = "ggyb"

    user_input = "c"
    guess = Guess.new(stubbed_combo, user_input)
    print_cheat = guess.evaluate_user_input(stubbed_combo, user_input)

    p print_cheat
    puts '~'*50

    user_input = "bby"
    guess = Guess.new(stubbed_combo, user_input)
    too_short = guess.evaluate_user_input(stubbed_combo, user_input)

    p too_short
    puts '~'*50

    user_input = "bbybb"
    guess = Guess.new(stubbed_combo, user_input)
    too_long = guess.evaluate_user_input(stubbed_combo, user_input)

    p too_long
    puts '~'*50

    user_input = "bbyb"
    guess = Guess.new(stubbed_combo, user_input)
    correct_length = guess.evaluate_user_input(stubbed_combo, user_input)

    p correct_length
    puts '~'*50

    user_input = "ggyb"
    guess = Guess.new(stubbed_combo, user_input)
    correct_guess = guess.evaluate_user_input(stubbed_combo, user_input)

    p correct_length
    puts "\n"
  end
end
