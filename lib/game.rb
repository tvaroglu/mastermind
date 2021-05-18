class Game

  def initialize
    @welcome_message = [
      'Welcome to MASTERMIND',
      'Would you like to (p)lay, read the (i)nstructions, or (q)uit?',
      ' >'
    ]
    @instructions = [
      'You will be presented with a sequence of four elements (colors).',
      'There are four possible colors (red, green, blue, and yellow).',
      'Each color is represented by the first letter (i.e. "r" = "red").',
      'Guess the correct four color combination to win the game (i.e. "yrbg").',
      'Colors can repeat, and every color does not have to be used.',
      'Good luck!',
      '-'*30,
      'Type any key to continue.',
      ' >'
    ]
    @start_message = [
      "I have generated a beginner sequence with four elements made up of:",
      "(r)ed, (g)reen, (b)lue, and (y)ellow.",
      "Use (q)uit at any time to end the game.",
      "What's your guess?"
    ]
    @end_message = ''
  end

  def print_welcome
    @welcome_message.each do |line|
      puts line
    end
  end

  def print_start
    @start_message.each do |line|
      puts line
    end
  end

  def print_instructions
    @instructions.each do |line|
      puts line
    end
  end

  def start
    print_welcome
    user_input = $stdin.gets.chomp
    if user_input == 'p'.downcase
      print_start
      # call game.run (not yet created)
    elsif user_input == 'i'.downcase
      print_instructions
      user_input = $stdin.gets.chomp
      self.start
    elsif user_input == 'q'.downcase
      abort "Game exiting... \n Goodbye!"
    else
      self.start
    end
  end

end


g = Game.new
g.start
