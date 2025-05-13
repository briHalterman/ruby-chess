# spec/pieces/bishop_spec.rb
require 'spec_helper'
require_relative '../../lib/pieces/bishop'

RSpec.describe Bishop do
  let(:white_bishop) { Bishop.new(:white, [0, 2]) }
  let(:black_bishop) { Bishop.new(:black, [7, 2]) }
  let(:bishop) { Bishop.new(:white, [0, 2]) }
  let(:board) { double("Board") }

  describe '#symbol' do
    it 'returns ♗ for white bishops' do
      expect(white_bishop.symbol).to eq('♗')
    end

    it 'returns ♝ for black bishops' do
      expect(black_bishop.symbol).to eq('♝')
    end
  end

  describe '#valid_move?' do
    it 'returns true for a valid diagonal move' do
      expect(bishop.valid_move?([0, 2], [3, 5], board)).to be true
    end

    it 'returns false for a horizontal move' do
      expect(bishop.valid_move?([0, 2], [0, 5], board)).to be false
    end

    it 'returns false for a vertical move' do
      expect(bishop.valid_move?([0, 2], [3, 2], board)).to be false
    end
  end
end