require_relative 'combo'

class Guess
  # attr_reader modified for new instance variables
  attr_reader :combo_to_guess,
              :user_guess,
              :combo_array,
              :guess_array,
              :correct_char_positions
              :correct_elems_count

  def initialize(current_combo, current_guess)
    @combo_to_guess = current_combo
    @combo_array = @combo_to_guess.split('')

    @user_guess = current_guess.to_s.downcase
    @guess_array = @user_guess.split('')
    # NEW instance variables
    @correct_char_positions = 0
    @correct_elems_count = Hash.new(0)
  end

  def is_correct?
    return @combo_to_guess == @user_guess
  end

  def evaluate_user_input(combo_to_guess, current_guess)
    if current_guess.downcase == 'q' || current_guess.downcase == 'quit' # possible to refactor via [str, bool] retval syntax, to maintain SRP??
      abort "Game exiting... \n Goodbye!"
    elsif current_guess.downcase == 'c' || current_guess.downcase == 'cheat'
      return combo_to_guess
    elsif current_guess.length < combo_to_guess.length
      return 'Guess is too short. Try again!'
    elsif current_guess.length > combo_to_guess.length
      return 'Guess is too long. Try again!'
    else
      return self.evaluate_user_guess(combo_to_guess, current_guess)
    end
  end

  # Method modified
  def evaluate_user_guess(combo_to_guess, current_guess)
    if self.is_correct? == false
      @guess_array.each_with_index {
         |char, index| @correct_char_positions += 1 if @guess_array[index] == @combo_array[index]
       }

       combo_elems_counter = @combo_array.each_with_object(Hash.new(0)) {
         | elem, hash | hash[elem] += 1}
       guess_elems_counter = @guess_array.each_with_object(Hash.new(0)) {
         | elem, hash | hash[elem] += 1 if @combo_array.index(elem) != nil}
         guess_elems_counter.each do |char, frequency|
           if guess_elems_counter[char] >= combo_elems_counter[char]
             @correct_elems_count[char] = combo_elems_counter[char]
           else
             @correct_elems_count[char] = frequency
           end
         end
         @correct_elems_count = @correct_elems_count.values.sum { |val| val }

      return "
'#{current_guess.upcase}' has #{@correct_elems_count} of the correct element(s)
with #{@correct_char_positions} in the correct position(s)."

     end
    end


end


# test_guess = 'rbyy'
# g = Guess.new('yybr', test_guess)
#
# puts "Trying to guess #{'YYBR'}, by currently guessing '#{test_guess.upcase}'"
# puts '-'*30
# puts g.evaluate_user_input('yybr', test_guess)
