require 'json'

class Score
  attr_reader :player_name,
              :difficulty_level,
              :winning_sequence,
              :guess_counter,
              :elapsed_time,
              :file_path,
              :faster_vs_slower,
              :more_vs_fewer,
              :top_10

  def initialize(
    player_name, difficulty_level, winning_sequence, guess_counter, elapsed_time)

    @player_name = player_name.to_s.capitalize.to_sym
    @difficulty_level = difficulty_level.to_sym
    @winning_sequence = winning_sequence.to_s.upcase
    @guess_counter = guess_counter
    @elapsed_time = ((elapsed_time.split(' ')[0].to_i * 60) + (elapsed_time.split(' ')[2].to_i))

    @file_path = './lib/scores.json'
    @top_10 = Array.new
    @faster_vs_slower = 'faster than the average'
    @more_vs_fewer = 'fewer than the average'
  end


  def new_player_scoring(
    scores_hash, player_name, difficulty_level, winning_sequence, num_guesses, elapsed_time)

    scores_hash[player_name] = {
      difficulty_level => {
        :most_recent_game => {
          :winning_sequence => winning_sequence,
          :num_guesses => num_guesses,
          :elapsed_time_in_seconds => elapsed_time
        },
        :all_games_played => Array.new
      }
    }
    scores_hash[player_name][difficulty_level][:all_games_played].push(
      scores_hash[player_name][difficulty_level][:most_recent_game])
  end


  def existing_player_new_difficulty_scoring(
    scores_hash, player_name, difficulty_level, winning_sequence, num_guesses, elapsed_time)

    scores_hash[player_name][difficulty_level] = {
      :most_recent_game => {
        :winning_sequence => winning_sequence,
        :num_guesses => num_guesses,
        :elapsed_time_in_seconds => elapsed_time
      },
      :all_games_played => Array.new
    }
    scores_hash[player_name][difficulty_level][:all_games_played].push(
      scores_hash[player_name][difficulty_level][:most_recent_game])
  end


  def existing_player_scoring(
    scores_hash, player_name, difficulty_level, winning_sequence, num_guesses, elapsed_time)

    scores_hash[player_name][difficulty_level]['most_recent_game'] = {
      'winning_sequence': winning_sequence,
      'num_guesses': num_guesses,
      'elapsed_time_in_seconds': elapsed_time
    }
    scores_hash[player_name][difficulty_level]['all_games_played'].push(
      scores_hash[player_name][difficulty_level]['most_recent_game'])
  end


  def aggregate_scores(
    scores_hash, player_name, difficulty_level, winning_sequence, num_guesses, elapsed_time)

    player_name = player_name.to_s
    difficulty_level = difficulty_level.to_s
    if scores_hash.keys.index(player_name) == nil
      self.new_player_scoring(
        scores_hash, player_name, difficulty_level, winning_sequence, num_guesses, elapsed_time)
    elsif scores_hash[player_name].keys.index(difficulty_level) == nil
      self.existing_player_new_difficulty_scoring(
        scores_hash, player_name, difficulty_level, winning_sequence, num_guesses, elapsed_time)
    else
      self.existing_player_scoring(
        scores_hash, player_name, difficulty_level, winning_sequence, num_guesses, elapsed_time)
    end
  end


  def retrieve_scores_file
    reader = File.read(@file_path)
    json_blob = JSON.parse(reader)
    return json_blob
  end

  def write_scores
    json_blob = self.retrieve_scores_file
    self.aggregate_scores(
      json_blob, @player_name, @difficulty_level, @winning_sequence, @guess_counter, @elapsed_time)
    writer = File.open(@file_path, 'w')
    File.write(writer, JSON.pretty_generate(json_blob))
    writer.close
  end

  def retrieve_metrics
    json_blob = self.retrieve_scores_file
    total_games = 0
    total_time = 0
    total_guesses = 0
    json_blob.each do |player, difficulty_level|
      difficulty_level.each do |game, metrics|
        all_games_played = metrics['all_games_played']
        all_games_played.each do |game|
          total_games += 1
          total_guesses += game['num_guesses']
          total_time += game['elapsed_time_in_seconds']
          @top_10.push([player, game['winning_sequence'], game['num_guesses'], game['elapsed_time_in_seconds']])
        end
      end
    end
    average_guesses = (total_guesses.to_f / total_games).round
    average_time = (total_time.to_f / total_games).round
    self.congratulate_player(average_guesses, average_time)
    self.print_top_10_scores
  end

  def congratulate_player(avg_guesses, avg_time)
    self.update_grammar(avg_guesses, avg_time)
  	congratulations = [
      "#{@player_name.to_s}, you guessed the sequence '#{@winning_sequence}' in #{@guess_counter} guesses over #{self.convert_time(@elapsed_time)}.",
      "That's #{self.convert_time((@elapsed_time - avg_time).abs)} #{@faster_vs_slower} and #{(@guess_counter - avg_guesses).abs} guesses #{@more_vs_fewer}."
    ]
    congratulations.each { |line| puts line }
  end

  def update_grammar(avg_guesses, avg_time)
    @faster_vs_slower = 'slower than the average' if @elapsed_time > avg_time
    @more_vs_fewer = 'more than the average' if @guess_counter > avg_guesses
  end

  def convert_time(num_seconds)
    minutes = (num_seconds / 60.to_f).floor
    seconds = (num_seconds % 60).round
    return "#{minutes} minute(s) #{seconds} second(s)"
  end

  def print_top_10_scores
    puts "\n=== TOP 10 ==="
    @top_10 = @top_10.sort_by { |game| [ game[2], game[3] ] }
    score_output_count = 1
    @top_10[0..9].each do |score|
      puts "#{score_output_count}. #{score[0]} solved '#{score[1]}' in #{score[2]} guesses over #{self.convert_time(score[3])}."
      score_output_count += 1
    end
  end


end
