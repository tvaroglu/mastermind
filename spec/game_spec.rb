require 'rspec'
require_relative '../lib/game'

RSpec.describe Game do
  before :each do
    @game = Game.new
  end

  it 'initializes' do
    expect(@game).to be_an_instance_of(Game)
  end

  it 'prints messages' do
    puts "\n"
    expect(@game.print_welcome.to_s).to include('Welcome', '(p)lay', ' >')
    puts "\n"
    puts '~'*50
    expect(@game.print_start.to_s).to include('generated', '(b)lue', '(q)uit', 'your guess?')
    puts "\n"
    puts '~'*50
    expect(@game.print_instructions.to_s).to include('presented', 'four', 'represented', 'combination', 'repeat,', 'luck!', '-', 'press', ' >')
    puts "\n"
    puts '~'*50
    # include assertion for end_message once game.run is created
  end
end
