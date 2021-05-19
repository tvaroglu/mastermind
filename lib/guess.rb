class Guess
  attr_reader :winning_combo, :user_guess #placeholders

  def initialize
    @winning_combo = 'yrbg' #placeholders
    @user_guess = 'bybb' #placeholders
  end

  ## Stubbed Guess.evaluate method, for testing purposes:
  def evaluate(combo_to_guess, current_guess)
    combo_array = combo_to_guess.split('')
    guess_array = current_guess.split('')

    if current_guess.length < combo_to_guess.length
      return 'Guess it too short. Try again!'
    elsif current_guess.length > combo_to_guess.length
      return 'Guess it too long. Try again!'
    elsif current_guess.downcase == 'q'
      abort "Game exiting... \n Goodbye!"
    elsif current_guess.downcase == 'c'
      return combo_to_guess
    else
      correct_chars = 0

      guess_array.each_with_index do |char, index|
        if guess_array[index] == combo_array[index]
          correct_chars +=1
        end
      end

    # Check each element of our guess array and see if it's inside the combo array =+1 to our element counter.

  	# winning_combo = [y,r,b,g]
  	# guess array [b,y,b,b]

      correct_elems = guess_array.count do |char|
        combo_array.index(char) != nil
      end

      # correct_elems_count = correct_elems.length

      return "'#{current_guess.upcase}' has #{correct_elems} of the correct elements with #{correct_chars} in the correct positions!"
    end
  end
end

guess = Guess.new
p guess.evaluate(guess.winning_combo, guess.user_guess)
