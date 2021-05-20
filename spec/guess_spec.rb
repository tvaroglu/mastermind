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

  context "evaluate_user_input" do
    before :each do
      @stubbed_combo = "ggyb"
    end

    it "returns the answer if you cheat" do
      user_input = "c"
      guess = Guess.new(@stubbed_combo, user_input)

      expect(guess.evaluate_user_input(@stubbed_combo, user_input)).to eq(@stubbed_combo)
    end

    it "has too short of a guess" do
      user_input = "bby"
      guess = Guess.new(@stubbed_combo, user_input)

      expect(guess.evaluate_user_input(@stubbed_combo, user_input)).to eq('Guess is too short. Try again!')
    end

    it "has too long of a guess" do
      user_input = "bbybb"
      guess = Guess.new(@stubbed_combo, user_input)

      expect(guess.evaluate_user_input(@stubbed_combo, user_input)).to eq('Guess is too long. Try again!')
    end

    it "evaluates a guess if the guess length == answer length" do
      user_input = "bbyb"
      guess = Guess.new(@stubbed_combo, user_input)

      expect(guess.evaluate_user_input(@stubbed_combo, user_input)).to eq("'BBYB' has 2 of the correct elements with 2 in the correct positions")

      user_input = "gbyb"
      guess = Guess.new(@stubbed_combo, user_input)

      expect(guess.evaluate_user_input(@stubbed_combo, user_input)).to eq("'GBYB' has 3 of the correct elements with 3 in the correct positions")
    end

    it "has a correct or incorrect guess" do
      user_input = "ggyb"
      guess = Guess.new(@stubbed_combo, user_input)

      expect(guess.is_correct?).to eq(true)

      user_input = "ygyb"
      guess = Guess.new(@stubbed_combo, user_input)

      expect(guess.is_correct?).to eq(false)
    end
  end
end
