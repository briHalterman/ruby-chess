# spec/board_spec.rb
require 'spec_helper'
require_relative '../lib/board'

RSpec.describe Board do
  describe '#initialize' do
    it 'creates an 8x8 grid' do
      board = Board.new
      expect(board.grid.size).to eq(8)
      expect(board.grid.all? { |row| row.size == 8 }).to be true
    end
  end

  describe '#place_piece' do
    it 'places a piece at the given position on the grid' do
      board = Board.new
      mock_piece = double('Piece')
      board.place_piece(mock_piece, [3, 4])

      expect(board.grid[3][4]).to eq(mock_piece)
    end
  end
end