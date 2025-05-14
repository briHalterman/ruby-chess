# spec/pieces/knight_spec.rb
require 'spec_helper'
require_relative '../../lib/pieces/knight'

RSpec.describe Knight do
  let(:white_knight) { Knight.new(:white, [0, 1]) }
  let(:black_knight) { Knight.new(:black, [7, 1]) }
  let(:board) { double("Board")}

  describe '#symbol' do
    it 'returns ♘ for white knights' do
      expect(white_knight.symbol).to eq('♘')
    end

    it 'returns ♞ for black knights' do
      expect(black_knight.symbol).to eq('♞')
    end
  end

  describe '#valid_move?' do
    let(:knight) { Knight.new(:white, [7, 1]) }

    it 'returns true for a valid L-shaped move (2 up, 1 right)' do
      expect(knight.valid_move?([7, 1], [5, 2], board)).to be true
    end

    it 'returns true for a valid L-shaped move (2 left 1 up)' do
      expect(knight.valid_move?([7, 1], [6, 3], board)).to be true
    end

    it 'returns false for a straight move' do
      expect(knight.valid_move?([7, 1], [5, 1], board)).to be false
    end

    it 'returns false for a diagonal move' do
      expect(knight.valid_move?([7, 1], [6, 2], board)).to be false
    end

    it 'returns false for a move to the same square' do
      expect(knight.valid_move?([7, 1], [7, 1], board)).to be false
    end
  end
end