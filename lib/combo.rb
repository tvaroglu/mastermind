class Combo
  attr_reader :difficulties, :difficulty_level, :mixer

  def initialize(difficulty_level='b')
    @difficulty_level = difficulty_level.to_s.downcase[0].to_sym

    @difficulties = {
      :b => {
        :colors => ['r', 'g', 'b', 'y'],
        :num_chars => 4,
        :start_message => [
          'I have generated a beginner sequence with four elements made up of:',
          '(r)ed, (g)reen, (b)lue, and (y)ellow.'
        ]
      },
      :i => {
        :colors => ['r', 'g', 'b', 'y', 'p'],
        :num_chars => 6,
        :start_message => [
          'I have generated an intermediate sequence with six elements made up of:',
          '(r)ed, (g)reen, (b)lue, (y)ellow, and (p)ink.'
        ]
      },
      :a => {
        :colors => ['r', 'g', 'b', 'y', 'p', 'o'],
        :num_chars => 8,
        :start_message => [
          'I have generated an advanced sequence with eight elements made up of:',
          '(r)ed, (g)reen, (b)lue, (y)ellow, (p)ink, and (o)range.'
        ]
      }
    }

    @difficulty_level = :b if @difficulties.keys.index(@difficulty_level) == nil

    @mixer = Array.new
    until @mixer.length == @difficulties[@difficulty_level][:num_chars]
      @mixer << @difficulties[@difficulty_level][:colors].sample(1)
    end

    @mixer = @mixer.join
  end


end
