require 'rspec'
require_relative 'spec_helper'

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

    expect(@score.total_games).to eq(0)
    expect(@score.total_time).to eq(0)
    expect(@score.total_guesses).to eq(0)
  end

  it 'can retrieve scores and reset metrics' do
    expect(@score.retrieve_scores).to be_a(Hash)
    expect(@score.retrieve_metrics).to eq(@score.top_10)

    @score.instance_variable_set(:@total_games, 8)
    @score.instance_variable_set(:@total_time, 140)
    @score.instance_variable_set(:@total_guesses, 13)

    expect(@score.total_games).to eq(8)
    expect(@score.total_time).to eq(140)
    expect(@score.total_guesses).to eq(13)

    @score.reset_metrics

    expect(@score.total_games).to eq(0)
    expect(@score.total_time).to eq(0)
    expect(@score.total_guesses).to eq(0)
  end

  it 'can convert time' do
    expect(@score.convert_time(@score.elapsed_time)).to eq('2 minute(s) 30 second(s)')
  end

  context 'it can congratulate a player for winning the game' do
    it 'is a player slower than average, but more deliberate than average' do
      average_guesses = 13
      average_time = 140

      @score.update_grammar(average_guesses, average_time)

      expected = [
        "\n#{@score.player_name}, you guessed the sequence '#{@score.winning_sequence}' in #{@guess_counter} guesses over #{@score.convert_time(@score.elapsed_time)}.",
        "That's #{@score.convert_time((@score.elapsed_time - average_time).abs)} #{@score.faster_vs_slower} and #{(@guess_counter - average_guesses).abs} guesses #{@score.more_vs_fewer}."
      ]
      expect(@score.congratulate_player(average_guesses, average_time)).to eq(expected)
    end

    it 'is a player faster than average, but less deliberate than average' do
      average_guesses = 6
      average_time = 160

      @score.update_grammar(average_guesses, average_time)

      expected = [
        "\n#{@score.player_name}, you guessed the sequence '#{@score.winning_sequence}' in #{@guess_counter} guesses over #{@score.convert_time(@score.elapsed_time)}.",
        "That's #{@score.convert_time((@score.elapsed_time - average_time).abs)} #{@score.faster_vs_slower} and #{(@guess_counter - average_guesses).abs} guesses #{@score.more_vs_fewer}."
      ]
      expect(@score.congratulate_player(average_guesses, average_time)).to eq(expected)
    end

    it 'is a player that performs exactly equal to average metrics' do
      average_guesses = 12
      average_time = 150

      @score.update_grammar(average_guesses, average_time)

      expected = [
        "\n#{@score.player_name}, you guessed the sequence '#{@score.winning_sequence}' in #{@guess_counter} guesses over #{@score.convert_time(@score.elapsed_time)}.",
        "That's #{@score.convert_time((@score.elapsed_time - average_time).abs)} #{@score.faster_vs_slower} and #{(@guess_counter - average_guesses).abs} guesses #{@score.more_vs_fewer}."
      ]
      expect(@score.congratulate_player(average_guesses, average_time)).to eq(expected)
    end
  end

  it 'can print high scores' do
    @score.instance_variable_set(:@total_games, 8)
    @score.instance_variable_set(:@total_time, 140)
    @score.instance_variable_set(:@total_guesses, 13)

    expect(@score.print_top_10_scores).to eq(@score.top_10)
  end

end
