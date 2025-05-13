# spec/pieces/queen_spec.rb
require 'spec_helper'
require_relative '../../lib/pieces/queen'

RSpec.describe Queen do
  let(:white_queen) { Queen.new(:white, [0, 4]) }
  let(:black_queen) { Queen.new(:black, [7, 4]) }
  let(:queen) { Queen.new(:white, [0, 3])}
  let(:board) { double("Board")}

  describe '#symbol' do
    it 'returns ♕ for white queens' do
      expect(white_queen.symbol).to eq('♕')
    end

    it 'returns ♛ for black queens' do
      expect(black_queen.symbol).to eq('♛')
    end
  end

  describe '#valid_move?' do
    it 'returns true for a vertical move' do
      expect(queen.valid_move?([0, 3], [4, 3], board)).to be true
    end

    it 'returns true for a horizontal move' do
      expect(queen.valid_move?([0, 3], [0, 6], board)).to be true
    end

    it 'returns true for a diagonal move' do
      expect(queen.valid_move?([0, 3], [3, 6], board)).to be true
    end

    it 'returns false for an invalid L-shaped move' do
      expect(queen.valid_move?([0, 3], [1, 5], board)).to be false
    end
  end
end