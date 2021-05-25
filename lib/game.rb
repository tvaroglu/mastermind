require_relative 'combo'
require_relative 'guess'
require_relative 'score'

class Game
  attr_reader :welcome_message,
              :instructions,
              :start_message,
              :guess_counter,
              :starting_time,
              :ending_time,
              :singular_vs_plural,
              :difficulty_level,
              :winning_sequence

  def initialize
    @welcome_message = [
      'Welcome to MASTERMIND',
      'Would you like to (p)lay, read the (i)nstructions, or (q)uit?',
      ' >'
    ]
    @instructions = [
      'You will be presented with a sequence of colors.',
      'There are four possible colors (red, green, blue, and yellow).',
      'Each color is represented by the first letter (i.e. "r" = "red").',
      'Guess the correct four color combination to win the game (i.e. "yrbg").',
      'Colors can repeat, and every color does not have to be used.',
      'Intermediate and Advanced difficulty levels will have longer and more complex sequences.',
      'Good luck!',
      '-'*30,
      'Press "Enter" to continue.',
      ' >'
    ]
    @start_message = [
      '',
      '',
      'Use (q)uit at any time to end the game.',
      "What's your guess?",
      ' >'
    ]
    @guess_counter = 0
    @starting_time = 0
    @ending_time = 0
    @singular_vs_plural = 'guess'
    @difficulty_level = :b
    @winning_sequence = ''
  end

  def timer
    total_time = (@ending_time - @starting_time).to_f
    minutes = (total_time / 60.to_f).floor
    seconds = (total_time % 60).round
    return "#{minutes} minute(s) #{seconds} second(s)"
  end

  def increment_guesses
    @guess_counter += 1
  end

  def reset_guesses
    @guess_counter = 0
    @singular_vs_plural = 'guess'
  end

  def print_victory
    self.increment_guesses
    @singular_vs_plural = 'guesses' if @guess_counter >= 2
    @ending_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    end_message = [
      "Congratulations! You guessed the sequence '#{@winning_sequence.upcase}'",
      "in #{@guess_counter} #{@singular_vs_plural} over #{self.timer}.",
      'Do you want to (p)lay again or (q)uit?',
      ' >'
    ]
    end_message[0..1].each { |line| puts line }
    self.collect_high_score
    end_message[2..3].each { |line| puts line }
  end

  def collect_high_score
    puts "Congratulations! You've guessed the sequence! What's your name? \n >"
    user_name = $stdin.gets.chomp
    score = Score.new(
      user_name, @difficulty_level, @winning_sequence, @guess_counter, self.timer)
    score.write_scores
    score.retrieve_metrics
  end

  def end_game
    self.print_victory
    user_selection = $stdin.gets.chomp
    if user_selection.downcase[0] == 'p' || user_selection.downcase == ''
      self.reset_guesses
      self.start
    else
      abort "Game exiting... \n Goodbye!"
    end
  end

  def print_welcome
    @welcome_message.each { |line| puts line }
  end

  def select_difficulty
    puts 'Please enter a difficulty level:'
    puts "(b)eginner, (i)ntermediate, or (a)dvanced. \n >"
    user_selection = $stdin.gets.chomp
    if user_selection == ''
      @difficulty_level = :b
    else
      @difficulty_level = Combo.new(user_selection[0]).difficulty_level
    end
  end

  def print_start
    @start_message[0..1] = Combo.new(
      @difficulty_level).difficulties[@difficulty_level][:start_message][0..1]
    @starting_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    @start_message.each { |line| puts line }
  end

  def print_instructions
    @instructions.each { |line| puts line }
    user_input = $stdin.gets.chomp
    self.start
  end

  def start
    self.print_welcome
    user_selection = $stdin.gets.chomp
    if user_selection.downcase[0] == 'p'
      self.select_difficulty
      self.print_start
      user_guess = $stdin.gets.chomp
      self.run(Guess.new((Combo.new(@difficulty_level).mixer), user_guess))
      # self.run(Guess.new("yybr", user_guess)) # stub for user testing
    elsif user_selection.downcase[0] == 'i'
      self.print_instructions
    elsif user_selection.downcase[0] == 'q'
      abort "Game exiting... \n Goodbye!"
    else
      self.start
    end
  end

  def try_again(last_guess)
    self.increment_guesses unless last_guess.downcase == 'c' || last_guess.downcase == 'cheat'
    if @guess_counter == 1
      return "You've taken #{@guess_counter} guess. \n >"
    else
      return "You've taken #{@guess_counter} guesses. \n >"
    end
  end

  def run(first_guess)
    @winning_sequence = first_guess.combo_to_guess
    if first_guess.is_correct?
      self.end_game
    else
      current_guess = first_guess
      until current_guess.user_guess == @winning_sequence
        puts current_guess.evaluate_user_input(@winning_sequence, current_guess.user_guess)
        puts self.try_again(current_guess.user_guess)
        next_guess = $stdin.gets.chomp
        current_guess = Guess.new(@winning_sequence, next_guess)
      end
      self.end_game
    end
  end

end
