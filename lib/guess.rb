class Guess
  attr_reader :combo_to_guess,
              :user_guess,
              :combo_array,
              :guess_array

  def initialize(current_combo, current_guess)
    @combo_to_guess = current_combo
    @combo_array = @combo_to_guess.split('')

    @user_guess = current_guess.to_s.downcase
    @guess_array = @user_guess.split('')
  end

  def is_correct?
    @combo_to_guess == @user_guess
  end

  def evaluate_user_input(combo_to_guess, current_guess)
    if current_guess.downcase == 'q' || current_guess.downcase == 'quit'
      abort "Game exiting... \n Goodbye!"
    elsif current_guess.downcase == 'c' || current_guess.downcase == 'cheat'
      combo_to_guess
    elsif current_guess.length < combo_to_guess.length
      'Guess is too short. Try again!'
    elsif current_guess.length > combo_to_guess.length
      'Guess is too long. Try again!'
    else
      evaluate_user_guess(combo_to_guess, current_guess)
    end
  end

  def evaluate_user_guess(combo_to_guess, current_guess)
    if is_correct? == false
      correct_char_positions = 0
      correct_elems_count = Hash.new
      @guess_array.each_with_index do |char, index|
        correct_char_positions += 1 if @guess_array[index] == @combo_array[index]
        correct_elems_count[char] = true if @combo_array.index(char) != nil
      end
      result = [
        "'#{current_guess.upcase}' has #{correct_elems_count.keys.length} of the correct element(s)",
        "with #{correct_char_positions} in the correct position(s)."]
      result.each { |line| line }
    end
  end


end
