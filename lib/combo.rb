class Combo
  attr_reader :colors, :mixer

  def initialize
    @colors = ["r", "g", "b", "y"]

    @mixer = Array.new

    until @mixer.length == 4
      @mixer << @colors.sample(1)
    end

    @mixer = @mixer.join
  end
end
