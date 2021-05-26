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

  it 'initializes' do
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

  it 'can retrieve scores' do
    expect(@score.retrieve_scores_file).to be_a(Hash)
  end

  it 'can convert time' do
    expect(@score.convert_time(@score.elapsed_time)).to eq('2 minute(s) 30 second(s)')
  end

  context 'it can congratulate a player for winning the game' do
      it 'is a player slower than average, but more deliberate than average' do
        average_guesses = 13
        average_time = 140

        puts "\n"
        expect(@score.congratulate_player(average_guesses, average_time).to_s).to include(
          'Admin', 'BYRG', '12', '2 minute(s) 30 second(s)', '10', 'slower than', '1', 'fewer than')
      end

      it 'is a player faster than average, but less deliberate than average' do
        average_guesses = 6
        average_time = 160

        puts "\n"
        expect(@score.congratulate_player(average_guesses, average_time).to_s).to include(
          'Admin', 'BYRG', '12', '2 minute(s) 30 second(s)', '10', 'faster than', '6', 'more than')
      end

      it 'is a player that performs exactly equal to average metrics' do
        average_guesses = 12
        average_time = 150

        puts "\n"
        expect(@score.congratulate_player(average_guesses, average_time).to_s).to include(
          'Admin', 'BYRG', '12', '2 minute(s) 30 second(s)', '0', 'faster than', '0', 'fewer than')
      end
  end

end
