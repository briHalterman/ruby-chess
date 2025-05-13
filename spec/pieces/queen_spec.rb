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
      allow(board).to receive(:piece_at).and_return(nil)
      expect(queen.valid_move?([0, 3], [4, 3], board)).to be true
    end

    it 'returns true for a horizontal move' do
      allow(board).to receive(:piece_at).and_return(nil)
      expect(queen.valid_move?([0, 3], [0, 6], board)).to be true
    end

    it 'returns true for a diagonal move' do
      allow(board).to receive(:piece_at).and_return(nil)
      expect(queen.valid_move?([0, 3], [3, 6], board)).to be true
    end

    it 'returns false for an invalid L-shaped move' do
      expect(queen.valid_move?([0, 3], [1, 5], board)).to be false
    end

    it 'returns false if there is a piece blocking the diagonal path' do
      board = double("Board")
      queen = Queen.new(:white, [0, 3])

      allow(board).to receive(:piece_at).with([1, 4]).and_return(double("Piece"))
      allow(board).to receive(:piece_at).with([2, 5]).and_return(nil)

      expect(queen.valid_move?([0, 3], [3, 6], board)).to be false
    end

    it 'returns false if there is a piece blocking the vertical path' do
      board = double("Board")
      queen = Queen.new(:white, [0, 3])

      allow(board).to receive(:piece_at).with([1, 3]).and_return(double("Piece"))
      allow(board).to receive(:piece_at).with([2, 3]).and_return(nil)

      expect(queen.valid_move?([0, 3], [3, 3], board)).to be false
    end
  end
end