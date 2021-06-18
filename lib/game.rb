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

  def select_difficulty
    puts "\nPlease select a difficulty level:"
    puts "(b)eginner, (i)ntermediate, or (a)dvanced.\n >"
    user_selection = $stdin.gets.chomp.downcase
    user_selection == '' ? @difficulty_level = :b : @difficulty_level = Combo.new(user_selection[0]).difficulty_level
  end

  def increment_guesses
    @guess_counter += 1
  end

  def reset_guesses
    @guess_counter = 0
    @singular_vs_plural = 'guess'
  end

  def timer
    total_time = (@ending_time - @starting_time).to_f
    minutes = (total_time / 60.to_f).floor
    seconds = (total_time % 60).round
    "#{minutes} minute(s) #{seconds} second(s)"
  end

  def print_victory
    increment_guesses
    @singular_vs_plural = 'guesses' if @guess_counter >= 2
    @ending_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    end_message = [
      "Congratulations! You guessed the sequence '#{@winning_sequence.upcase}'",
      "in #{@guess_counter} #{@singular_vs_plural} over #{timer}.",
      'Do you want to (p)lay again or (q)uit?',
      ' >'
    ]
    end_message[0..1].each { |line| puts line }
    collect_high_score
    end_message[2..3].each { |line| puts line }
  end

  def collect_high_score
    puts "Congratulations! You've guessed the sequence! What's your name?\n >"
    user_name = $stdin.gets.chomp
    if user_name == ''
      user_name = 'Player'
    end
    score = Score.new(
      user_name, @difficulty_level, @winning_sequence, @guess_counter, timer)
    score.write_scores
    score.retrieve_metrics
  end

  def end_game
    print_victory
    user_selection = $stdin.gets.chomp.downcase
    if user_selection[0] == 'p' || user_selection == ''
      reset_guesses
      start
    else
      puts "Game exiting... \n Goodbye!"
    end
  end

  def print_welcome
    @welcome_message.each { |line| line }
  end

  def print_instructions
    @instructions.each { |line| puts line }
    user_input = $stdin.gets.chomp
    start
  end

  def print_start
    @start_message[0..1] = Combo.new(
      @difficulty_level).difficulties[@difficulty_level][:start_message][0..1]
    @starting_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    @start_message.each { |line| line }
  end

  def start
    puts print_welcome
    user_selection = $stdin.gets.chomp.downcase
    if user_selection[0] == 'p'
      select_difficulty
      puts print_start
      user_guess = $stdin.gets.chomp
      run(Guess.new((Combo.new(@difficulty_level).mixer), user_guess))
    elsif user_selection[0] == 'i'
      print_instructions
    elsif user_selection[0] == 'q'
      puts "Game exiting... \n Goodbye!"
    else
      start
    end
  end

  def try_again(last_guess)
    increment_guesses unless last_guess.downcase == 'c' || last_guess.downcase == 'cheat'
    @guess_counter == 1 ? "You've taken #{@guess_counter} guess.\n >" : "You've taken #{@guess_counter} guesses.\n >"
  end

  def run(first_guess)
    @winning_sequence = first_guess.combo_to_guess
    if first_guess.is_correct?
      end_game
    else
      current_guess = first_guess
      until current_guess.user_guess == @winning_sequence
        puts current_guess.evaluate_user_input(@winning_sequence, current_guess.user_guess)
        puts try_again(current_guess.user_guess)
        next_guess = $stdin.gets.chomp
        current_guess = Guess.new(@winning_sequence, next_guess)
      end
      end_game
    end
  end

end
