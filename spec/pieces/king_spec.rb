# spec/pieces/king_spec.rb
require 'spec_helper'
require_relative '../../lib/pieces/king'

RSpec.describe King do
  let(:white_king) { King.new(:white, [0, 3]) }
  let(:black_king) { King.new(:black, [7, 3]) }
  let(:king) { King.new(:white, [0, 4]) }
  let(:board) { double("Board")}

  describe '#symbol' do
    it 'returns ♔ for white kings' do
      expect(white_king.symbol).to eq('♔')
    end

    it 'returns ♚ for black kings' do
      expect(black_king.symbol).to eq('♚')
    end
  end

  describe '#valid_move?' do
    it 'returns true for one square forward' do
      expect(king.valid_move?([4, 4], [3, 4], board)).to be true
    end

    it 'returns true for one square diagonal' do
      expect(king.valid_move?([4, 4], [5, 5], board)).to be true
    end

    it 'returns false for more than one square' do
      expect(king.valid_move?([4, 4], [6, 4], board)).to be false
    end

    it 'returns false for L-shaped moves' do
      expect(king.valid_move?([4, 4], [6, 4], board)).to be false
    end
  end
end