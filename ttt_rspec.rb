require 'rspec'
require_relative 'controller.rb'

describe "Tic Tac Toe" do
  let(:one) {Controller.new(Model.new, View.new)}

  it 'should start with an an array of 1-9 as the values' do
    expect(one.game.values).to eq [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  it 'should start with an array of dashes as the marked_squares' do
    expect(one.game.marked_squares).to eq %w(- - - - - - - - -)
  end

end
