# spec/board_spec.rb
require 'spec_helper'
require_relative '../lib/board'

RSpec.describe Board do
  let(:board) { Board.new }
  let(:mock_piece) { double('Piece') }

  describe '#initialize' do
    it 'creates an 8x8 grid' do
      expect(board.grid.size).to eq(8)
      expect(board.grid.all? { |row| row.size == 8 }).to be true
    end
  end

  describe '#place_piece' do
    it 'places a piece at the given position on the grid' do
      board.place_piece(mock_piece, [3, 4])

      expect(board.grid[3][4]).to eq(mock_piece)
    end
  end

  describe '#piece_at' do
    it 'returns the piece at the given position' do
      board.place_piece(mock_piece, [1, 1])

      expect(board.piece_at([1, 1])).to eq(mock_piece)
    end
  end

  describe '#move_piece' do
    it 'moves a piece from one position to another' do
      board.place_piece(mock_piece, [0, 0])
      board.move_piece([0, 0], [3, 4])

      expect(board.grid[0][0]).to be_nil
      expect(board.grid[3][4]).to eq(mock_piece)
    end
  end

  describe '#place_starting_pieces' do
    before { board.place_starting_pieces }

  # OBSOLETE
  #   it 'places white pieces in starting positions' do
  #     board.place_starting_pieces

  #     expect(board.piece_at([0, 0])).not_to be_nil
  #     expect(board.piece_at([1, 0])).not_to be_nil
  #     expect(board.piece_at([1, 4])).not_to be_nil
  #   end

    it 'places white pawns on row 2' do
      8.times do |column|
        expect(board.piece_at([1, column])).to eq(:white_pawn)
      end
    end

    it 'places white rooks in the corners of row 1' do
      expect(board.piece_at([0, 0])).to eq(:white_rook)
      expect(board.piece_at([0, 7])).to eq(:white_rook)
    end

    it 'places white knights next to white rooks' do
      expect(board.piece_at([0, 1])).to eq(:white_knight)
      expect(board.piece_at([0, 6])).to eq(:white_knight)
    end
  end
end