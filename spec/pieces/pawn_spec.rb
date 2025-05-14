# spec/pieces/pawn_spec.rb
require 'spec_helper'
require_relative '../../lib/pieces/pawn'

RSpec.describe Pawn do
  let(:white_pawn) { Pawn.new(:white, [1, 0]) }
  let(:black_pawn) { Pawn.new(:black, [6, 0]) }
  let(:board) { double("Board") }

  describe '#symbol' do
    it 'returns ♙ for white pawns' do
      expect(white_pawn.symbol).to eq('♙')
    end

    it 'returns ♟ for black pawns' do
      expect(black_pawn.symbol).to eq('♟')
    end
  end

  context 'white pawn' do
    let(:pawn) { Pawn.new(:white, [1, 4]) }

    it 'can move one space forward' do
      expect(pawn.valid_move?([1, 4], [2, 4], board)).to be true
    end

    it 'can move two space from starting position' do
      expect(pawn.valid_move?([1, 4], [3, 4], board)).to be true
    end

    it 'cannot move sideways' do
      expect(pawn.valid_move?([1, 4], [1, 5], board)).to be false
    end

    it 'can move diagonally if capturing an opponent piece' do
      target_piece = instance_double("Piece", color: :black)
      allow(board).to receive(:piece_at).with([2, 5]).and_return(target_piece)

      expect(pawn.valid_move?([1, 4], [2, 5], board)).to be true
    end
  end
end