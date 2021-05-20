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
      ## Note, initialize method will need to be refactored for other difficulty levels
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
      ## Note, initialize method will need to be refactored for other difficulty levels
      'I have generated a beginner sequence with four elements made up of:',
      '(r)ed, (g)reen, (b)lue, and (y)ellow.',
      'Use (q)uit at any time to end the game.',
      "What's your guess?",
      ' >'
    ]
    @guess_counter = 0
    @starting_time = 0
    @ending_time = 0
    @winning_sequence = ''
  end

  def timer
    total_time = (@ending_time - @starting_time).to_f
    minutes = (total_time/60.to_f).floor
    seconds = (total_time % 60).floor
    return "#{minutes} minute(s) #{seconds} second(s)"
  end

  def end_game
    single_vs_plural = "guesses"
    single_vs_plural = 'guess' if @guess_counter == 1
    @ending_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    end_message = [
      "Congratulations! You guessed the sequence '#{@winning_sequence.upcase}'",
      "in #{@guess_counter} #{single_vs_plural} over #{self.timer} seconds.",
      'Do you want to (p)lay again or (q)uit?',
      ' >'
    ]
    end_message.each { |line| puts line }
    user_input = $stdin.gets.chomp
    if user_input == 'p'.downcase
      @guess_counter = 0
      self.start
    elsif user_input == 'q'.downcase
      abort "Game exiting... \n Goodbye!"
    else
      self.end_game
    end
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
      @starting_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      user_input = $stdin.gets.chomp
      self.run(Guess.new(Combo.new.mixer, user_input))
      # self.run(Guess.new("yybr", user_input)) # for user testing
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

  def try_again
    @guess_counter += 1

    if @guess_counter == 1
      return "You've taken #{@guess_counter} guess. \n >"
    else
      return "You've taken #{@guess_counter} guesses. \n >"
    end
  end

  def run(first_guess)
    @winning_sequence = first_guess.combo_to_guess
    if first_guess.is_correct?
      @guess_counter = 1
      self.end_game
    else
      puts first_guess.evaluate_user_input(@winning_sequence, first_guess.user_guess)
      puts self.try_again
      next_guess = $stdin.gets.chomp
      current_guess = Guess.new(@winning_sequence, next_guess)
      until current_guess.user_guess == @winning_sequence
        puts current_guess.evaluate_user_input(@winning_sequence, current_guess.user_guess)
        puts self.try_again
        next_guess = $stdin.gets.chomp
        current_guess = Guess.new(@winning_sequence, next_guess)
      end
      self.end_game
    end
  end

end
# for testing locally
game = Game.new
game.start
