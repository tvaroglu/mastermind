require 'rspec'
require 'json'
require_relative '../lib/score'

RSpec.describe Score do

  before :each do
    @player_name = 'admin'
    @difficulty_level = :b
    @winning_sequence = 'byrg'
    @guess_counter = 12
    @elapsed_time = '2 minute(s) 30 second(s)'

    @score = Score.new(
      @player_name, @difficulty_level, @winning_sequence, @guess_counter, @elapsed_time)
  end

  it "initializes" do
    expect(@score).to be_an_instance_of(Score)
    expect(@score.player_name).to eq(:Admin)
    expect(@score.difficulty_level).to eq(:b)
    expect(@score.winning_sequence).to eq('BYRG')
    expect(@score.guess_counter).to eq(12)
    expect(@score.elapsed_time).to eq(150)
    expect(@score.file_path).to eq('./lib/scores.json')
    expect(@score.faster_vs_slower).to eq('faster than the average')
    expect(@score.more_vs_fewer).to eq('fewer than the average')
    expect(@score.top_10).to be_an(Array)
    expect(@score.top_10.length).to eq(0)
  end

  it "can retrieve scores" do
    expect(@score.retrieve_scores_file).to be_a(Hash)
  end

  it "can convert time" do
    expect(@score.convert_time(@score.elapsed_time)).to eq('2 minute(s) 30 second(s)')
  end

  xit "can congratulate a player" do
    average_guesses_1 = 13
    average_time_1 = 140

    @score.congratulate_player(average_guesses_1, average_time_1).to_s

    expect(@score.congratulate_player(average_guesses_1, average_time_1).to_s).to include(
      'Admin', 'BYRG', '12', '2 minute(s) 30 second(s)', '10', 'slower', '1', 'fewer')

    average_guesses_2 = 6
    average_time_2 = 205

    @score.congratulate_player(average_guesses_2, average_time_2).to_s
# require "pry"; binding.pry
    expect(@score.congratulate_player(average_guesses_2, average_time_2).to_s).to include(
      'Admin', 'BYRG', '12', '2 minute(s) 30 second(s)', '55', 'faster', '6', 'more than')

    average_guesses_3 = 12
    average_time_3 = 150

    @score.congratulate_player(average_guesses_3, average_time_3).to_s

    expect(@score.congratulate_player(average_guesses_3, average_time_3).to_s).to include(
      'Admin', 'BYRG', '12', '2 minute(s) 30 second(s)', '0', 'equal to', '0', 'equal to')

  end

end
