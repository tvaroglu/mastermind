require 'rspec'
require_relative '../lib/combo'

RSpec.describe Combo do
  it "initializes" do
    combo = Combo.new

    expect(combo).to be_an_instance_of(Combo)
    expect(combo.colors).to eq(["r", "g", "b", "y"])
    expect(combo.mixer).to be_an_instance_of(String)
    expect(combo.mixer.length).to eq(4)
  end
end
