require 'rspec'
require_relative '../lib/combo'
require_relative '../lib/guess'

RSpec.describe Guess do
  context "beginner difficulty level" do
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

        expect(guess.evaluate_user_input(@stubbed_combo, user_input)).to eq(
          @stubbed_combo)
      end

      it "has too short of a guess" do
        user_input = "bby"
        guess = Guess.new(@stubbed_combo, user_input)

        expect(guess.evaluate_user_input(@stubbed_combo, user_input)).to eq(
          'Guess is too short. Try again!')
      end

      it "has too long of a guess" do
        user_input = "bbybb"
        guess = Guess.new(@stubbed_combo, user_input)

        expect(guess.evaluate_user_input(@stubbed_combo, user_input)).to eq(
          'Guess is too long. Try again!')
      end

      it "evaluates a guess if the guess length == answer length" do
        user_input = "bbyb"
        guess = Guess.new(@stubbed_combo, user_input)

        expect(guess.evaluate_user_input(@stubbed_combo, user_input)).to eq(
          "'#{user_input.upcase}' has 2 of the correct element(s) with 2 in the correct position(s).")

        user_input = "gbyb"
        guess = Guess.new(@stubbed_combo, user_input)

        expect(guess.evaluate_user_input(@stubbed_combo, user_input)).to eq(
          "'#{user_input.upcase}' has 3 of the correct element(s) with 3 in the correct position(s).")
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

  context "intermediate difficulty level" do
    it "initializes" do
      user_input = "bypggr"
      guess = Guess.new(Combo.new(:i).mixer, user_input)

      expect(guess).to be_an_instance_of(Guess)

      expect(guess.user_guess).to eq("bypggr")
      expect(guess.user_guess).to be_an_instance_of(String)
      expect(guess.user_guess.length).to eq(6)
      expect(guess.user_guess.length).to eq(guess.guess_array.length)
      expect(guess.guess_array).to be_an_instance_of(Array)
      expect(guess.guess_array.length).to eq(6)

      expect(guess.combo_to_guess).to be_an_instance_of(String)
      expect(guess.combo_to_guess.length).to eq(6)
      expect(guess.combo_to_guess.length).to eq(guess.combo_array.length)
      expect(guess.combo_array).to be_an_instance_of(Array)
      expect(guess.combo_array.length).to eq(6)
    end

    context "evaluate_user_input" do
      before :each do
        @stubbed_combo = "rypbyg"
      end

      it "returns the answer if you cheat" do
        user_input = "c"
        guess = Guess.new(@stubbed_combo, user_input)

        expect(guess.evaluate_user_input(@stubbed_combo, user_input)).to eq(
          @stubbed_combo)
      end

      it "has too short of a guess" do
        user_input = "bbyg"
        guess = Guess.new(@stubbed_combo, user_input)

        expect(guess.evaluate_user_input(@stubbed_combo, user_input)).to eq(
          'Guess is too short. Try again!')
      end

      it "has too long of a guess" do
        user_input = "bbybbopr"
        guess = Guess.new(@stubbed_combo, user_input)

        expect(guess.evaluate_user_input(@stubbed_combo, user_input)).to eq(
          'Guess is too long. Try again!')
      end

      it "evaluates a guess if the guess length == answer length" do
        user_input = "rypbyr"
        guess = Guess.new(@stubbed_combo, user_input)

        expect(guess.evaluate_user_input(@stubbed_combo, user_input)).to eq(
          "'#{user_input.upcase}' has 4 of the correct element(s) with 5 in the correct position(s).")

        user_input = "gybpyr"
        guess = Guess.new(@stubbed_combo, user_input)

        expect(guess.evaluate_user_input(@stubbed_combo, user_input)).to eq(
          "'#{user_input.upcase}' has 5 of the correct element(s) with 2 in the correct position(s).")
      end

      it "has a correct or incorrect guess" do
        user_input = "rypbyg"
        guess = Guess.new(@stubbed_combo, user_input)

        expect(guess.is_correct?).to eq(true)

        user_input = "gybpyr"
        guess = Guess.new(@stubbed_combo, user_input)

        expect(guess.is_correct?).to eq(false)
      end
    end

    context "advanced difficulty level" do
      it "initializes" do
        user_input = "porgybbg"
        guess = Guess.new(Combo.new('a').mixer, user_input)

        expect(guess).to be_an_instance_of(Guess)

        expect(guess.user_guess).to eq("porgybbg")
        expect(guess.user_guess).to be_an_instance_of(String)
        expect(guess.user_guess.length).to eq(8)
        expect(guess.user_guess.length).to eq(guess.guess_array.length)
        expect(guess.guess_array).to be_an_instance_of(Array)
        expect(guess.guess_array.length).to eq(8)

        expect(guess.combo_to_guess).to be_an_instance_of(String)
        expect(guess.combo_to_guess.length).to eq(8)
        expect(guess.combo_to_guess.length).to eq(guess.combo_array.length)
        expect(guess.combo_array).to be_an_instance_of(Array)
        expect(guess.combo_array.length).to eq(8)
      end

      context "evaluate_user_input" do
        before :each do
          @stubbed_combo = "bobgpprr"
        end

        it "returns the answer if you cheat" do
          user_input = "c"
          guess = Guess.new(@stubbed_combo, user_input)

          expect(guess.evaluate_user_input(@stubbed_combo, user_input)).to eq(
            @stubbed_combo)
        end

        it "has too short of a guess" do
          user_input = "bob"
          guess = Guess.new(@stubbed_combo, user_input)

          expect(guess.evaluate_user_input(@stubbed_combo, user_input)).to eq(
            'Guess is too short. Try again!')
        end

        it "has too long of a guess" do
          user_input = "bobobobobobobob"
          guess = Guess.new(@stubbed_combo, user_input)

          expect(guess.evaluate_user_input(@stubbed_combo, user_input)).to eq(
            'Guess is too long. Try again!')
        end

        it "evaluates a guess if the guess length == answer length" do
          user_input = "ggboporr"
          guess = Guess.new(@stubbed_combo, user_input)

          expect(guess.evaluate_user_input(@stubbed_combo, user_input)).to eq(
            "'#{user_input.upcase}' has 5 of the correct element(s) with 4 in the correct position(s).")

          user_input = "bobgopgg"
          guess = Guess.new(@stubbed_combo, user_input)

          expect(guess.evaluate_user_input(@stubbed_combo, user_input)).to eq(
            "'#{user_input.upcase}' has 4 of the correct element(s) with 5 in the correct position(s).")
        end

        it "has a correct or incorrect guess" do
          user_input = "bobgpprr"
          guess = Guess.new(@stubbed_combo, user_input)

          expect(guess.is_correct?).to eq(true)

          user_input = "ggboporg"
          guess = Guess.new(@stubbed_combo, user_input)

          expect(guess.is_correct?).to eq(false)
        end
      end
    end
  end

end
