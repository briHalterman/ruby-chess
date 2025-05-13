# spec/pieces/rook_spec.rb
require 'spec_helper'
require_relative '../../lib/pieces/rook'

RSpec.describe Rook do
  let(:white_rook) { Rook.new(:white, [0, 0]) }
  let(:black_rook) { Rook.new(:black, [7, 0]) }
  let(:board) { double("Board") }

  describe '#symbol' do
    it 'returns ♖ for white rooks' do
      expect(white_rook.symbol).to eq('♖')
    end

    it 'returns ♜ for black rooks' do
      expect(black_rook.symbol).to eq('♜')
    end
  end

  describe '#valid_move?' do
    let(:rook) { Rook.new(:white, [0, 0]) }

    it 'returns true for a vertical move' do
      expect(rook.valid_move?([0, 0], [5, 0], board)).to be true
    end

    it 'returns false for a diagonal move' do
      expect(rook.valid_move?([0, 0], [3, 3], board)).to be false
    end

    it 'returns false if move does not change row or column' do
      expect(rook.valid_move?([0, 0], [0, 0], board)).to be false
    end
  end
end