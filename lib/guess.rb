require_relative 'combo'

class Guess
  attr_reader :combo_to_guess, :user_guess, :combo_array, :guess_array

  def initialize(current_combo, current_guess)
    @combo_to_guess = current_combo
    @combo_array = @combo_to_guess.split('')

    @user_guess = current_guess.to_s.downcase
    @guess_array = @user_guess.split('')
  end

  def evaluate_user_guess(combo_to_guess, current_guess)
    correct_char_positions = 0
    correct_elems_count = Hash.new

    @guess_array.each_with_index do |char, index|
      correct_char_positions += 1 if @guess_array[index] == @combo_array[index]
      correct_elems_count[char] = true if @combo_array.index(char) != nil
    end

    puts "'#{current_guess.upcase}' has #{correct_elems_count.keys.length} of the correct elements with #{correct_char_positions} in the correct positions"
  end

  def evaluate_user_input(combo_to_guess, current_guess)
    if current_guess.downcase == 'q'
    	abort "Game exiting... \n Goodbye!"
    elsif current_guess.downcase == 'c'
      puts combo_to_guess
    elsif current_guess.length < combo_to_guess.length
      puts 'Guess is too short. Try again!'
    elsif current_guess.length > combo_to_guess.length
      puts 'Guess is too long. Try again!'
    else
    	return self.evaluate_user_guess(combo_to_guess, current_guess)
    end
  end

end


# winning_combo = 'yrbg'
# user_guess = 'yrbg'
#
# guess = Guess.new(winning_combo, user_guess)
# # p guess
# guess.evaluate_user_input(winning_combo, user_guess)
