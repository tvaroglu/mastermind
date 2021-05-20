require_relative 'combo'

class Guess
  attr_reader :combo_to_guess, :user_guess, :combo_array, :guess_array

  def initialize(current_combo, current_guess)
    @combo_to_guess = current_combo
    @combo_array = @combo_to_guess.split('')

    @user_guess = current_guess.to_s.downcase
    @guess_array = @user_guess.split('')
  end

  def is_correct?
    return @combo_to_guess == @user_guess
  end

  def evaluate_user_input(combo_to_guess, current_guess)
    if current_guess.downcase == 'q' # possible to refactor via [str, bool] retval syntax, to maintain SRP
    	abort "Game exiting... \n Goodbye!"
    elsif current_guess.downcase == 'c'
      return combo_to_guess
    elsif current_guess.length < combo_to_guess.length
      return 'Guess is too short. Try again!'
    elsif current_guess.length > combo_to_guess.length
      return 'Guess is too long. Try again!'
    else
    	return self.evaluate_user_guess(combo_to_guess, current_guess)
    end
  end

  def evaluate_user_guess(combo_to_guess, current_guess)
    if self.is_correct? == false

      correct_char_positions = 0
      correct_elems_count = Hash.new

      @guess_array.each_with_index do |char, index|
        correct_char_positions += 1 if @guess_array[index] == @combo_array[index]
        correct_elems_count[char] = true if @combo_array.index(char) != nil
      end

      return "'#{current_guess.upcase}' has #{correct_elems_count.keys.length} of the correct elements with #{correct_char_positions} in the correct positions"
    end
  end


end
