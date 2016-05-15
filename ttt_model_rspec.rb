require 'rspec'
require_relative 'controller.rb'

describe "Tic Tac Toe Model" do
  let(:game) { Model.new }

   it 'should start with an an array of 1-9 as the values' do
    expect(game.values).to eq [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  it 'should start with an array of dashes as the marked_squares' do
    expect(game.marked_squares).to eq %w(- - - - - - - - -)
  end

  it 'should mark the first chosen square as an X' do
    allow(:game).to receive(:automated_first)
    expect(game.values).to include("X")
  end
end