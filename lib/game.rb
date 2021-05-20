require_relative 'combo'
require_relative 'guess'

class Game

  def initialize
    @welcome_message = [
      'Welcome to MASTERMIND',
      'Would you like to (p)lay, read the (i)nstructions, or (q)uit?',
      ' >'
    ]
    @instructions = [
      ## initialize method will need to be modified for other difficulty levels
      'You will be presented with a sequence of four elements (colors).',
      'There are four possible colors (red, green, blue, and yellow).',
      'Each color is represented by the first letter (i.e. "r" = "red").',
      'Guess the correct four color combination to win the game (i.e. "yrbg").',
      'Colors can repeat, and every color does not have to be used.',
      'Good luck!',
      '-'*30,
      'Type any key and press "Enter" to continue.',
      ' >'
    ]
    @start_message = [
      ## initialize method will need to be modified for other difficulty levels
      "I have generated a beginner sequence with four elements made up of:",
      "(r)ed, (g)reen, (b)lue, and (y)ellow.",
      "Use (q)uit at any time to end the game.",
      "What's your guess?",
      ' >'
    ]
    @guess_counter = 0
    @elapsed_time = 0
    @winning_sequence = ""
  end

  def end_game
    end_message = [
      "Congratulations! You guessed the sequence '#{@winning_sequence}'",
      "in #{@guess_counter} guesses over #{@elapsed_time}.",
      'Do you want to (p)lay again or (q)uit?'
    ]
    #call play again
    #call quit
  end


  def print_welcome
    @welcome_message.each { |line| puts line }
  end

  def print_start
    @start_message.each { |line| puts line }
  end

  def print_instructions
    @instructions.each { |line| puts line }
  end

  def start
    self.print_welcome
    user_input = $stdin.gets.chomp
    if user_input == 'p'.downcase
      self.print_start
      user_input = $stdin.gets.chomp
      self.run(Guess.new(Combo.new.mixer, user_input))
    elsif user_input == 'i'.downcase
      self.print_instructions
      user_input = $stdin.gets.chomp
      self.start
    elsif user_input == 'q'.downcase
      abort "Game exiting... \n Goodbye!"
    else
      self.start
    end
  end

  def run(first_guess)
    combo_to_guess = first_guess.combo_to_guess
    user_guess = first_guess.user_guess
    # stub
    puts "You are trying to guess '#{combo_to_guess}', and you guessed '#{user_guess}'"
  end

end


# game = Game.new
# game.start
