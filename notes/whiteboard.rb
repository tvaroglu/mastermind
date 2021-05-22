require_relative '../lib/game'
require_relative '../lib/combo'

game = Game.new
# game.start

# start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)

## New method to be created in Game class (Game.run called inside Game.start):
# def game.run()
	## New instance of Combo class created when Game.run is invoked:
	# current_combo = Combo.new
	## Variable assignment to capture Combo.mixer created from initialize:
	# random_sequence = current_combo.mixer
	# return random_sequence
# end


## Stubbed combo variable (from Game.run), for testing purposes:
# random_sequence = Game.run
# random_sequence = 'yrbg'

## until user_guess == random_sequence
	# guess_count = 0

	## Create a new Guess instance:
	# user_guess = $stdin.gets.chomp

	## User input passed as input parameter to Guess.new method:
	# current_guess = Guess.new(user_guess)

	## Guess.evaluate method to check user input vs current combo:
	# current_guess.evaluate(current_combo)

	# guess_count += 1
# end

## Once until loop breaks (user has guessed correctly), invoke Game.end method:
# game.end



### class Guess
## Stubbed Guess.evaluate methods, for testing purposes:
def evaluate_user_guess(combo_to_guess, current_guess)
  combo_array = combo_to_guess.split('')
  guess_array = current_guess.split('')

  correct_char_positions = 0
  correct_elems_count = Hash.new

  guess_array.each_with_index do |char, index|
    correct_char_positions += 1 if guess_array[index] == combo_array[index]
	correct_elems_count[char] = true if combo_array.index(char) != nil
  end

  puts "'#{current_guess.upcase}' has #{correct_elems_count.keys.length} of the correct elements with #{correct_char_positions} in the correct positions"
end

def evaluate_user_input(combo_to_guess, current_guess)
  if current_guess.downcase == 'q'
	  abort "Game exiting... \n Goodbye!" if current_guess.downcase == 'q'
  elsif current_guess.downcase == 'c'
    puts combo_to_guess
  elsif current_guess.length < combo_to_guess.length
    puts 'Guess is too short. Try again!'
  elsif current_guess.length > combo_to_guess.length
    puts 'Guess is too long. Try again!'
  else
	  return evaluate_user_guess(combo_to_guess, current_guess)
  end
end


winning_combo = 'ggyb'
user_guess = 'bbyb'

evaluate_user_input(winning_combo, user_guess)


# end_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)

# elapsed_time = start_time - end_time
# p elapsed_time
