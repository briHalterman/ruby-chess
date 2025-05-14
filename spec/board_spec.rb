# spec/board_spec.rb
require 'spec_helper'
require_relative '../lib/board'

RSpec.describe Board do
  let(:board) { Board.new }
  let(:mock_piece) { double('Piece') }

  def expect_piece_at(position, klass, color)
    piece = board.piece_at(position)
    expect(piece).to be_a(klass)
    expect(piece.color).to eq(color)
  end

  describe '#initialize' do
    it 'creates an 8x8 grid' do
      expect(board.grid.size).to eq(8)
      expect(board.grid.all? { |row| row.size == 8 }).to be true
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

    context 'white pawns' do
      it 'places white pawns on row 2' do
        8.times do |column|
          # expect(board.piece_at([1, column])).to eq(:white_pawn) <- OBSOLETE
          piece = board.piece_at([1, column])
          expect(piece).to be_a(Pawn)
          expect(piece.color).to eq(:white)
        end
      end
    end

    context 'white major pieces' do
      it 'places white rooks in the corners of row 1' do
        # expect(board.piece_at([0, 0])).to eq(:white_rook) <- OBSOLETE
        expect_piece_at([0, 0], Rook, :white)

        # expect(board.piece_at([0, 7])).to eq(:white_rook) <- OBSOLETE
        expect_piece_at([0, 7], Rook, :white)
      end

      it 'places white knights next to white rooks' do
        # expect(board.piece_at([0, 1])).to eq(:white_knight) <- OBSOLETE
        expect_piece_at([0, 1], Knight, :white)

        # expect(board.piece_at([0, 6])).to eq(:white_knight) <- OBSOLETE
        expect_piece_at([0, 6], Knight, :white)
      end

      it 'places white bishops next to white knights' do
        # expect(board.piece_at([0, 5])).to eq(:white_bishop) <- OBSOLETE
        expect_piece_at([0, 5], Bishop, :white)

        # expect(board.piece_at([0, 2])).to eq(:white_bishop) <- OBSOLETE
        expect_piece_at([0, 2], Bishop, :white)
      end

      it 'places white queen on middle white square' do
        # expect(board.piece_at([0, 3])).to eq(:white_queen) <- OBSOLETE
        expect_piece_at([0, 3], Queen, :white)
      end

      it 'places white king next to white queen' do
        # expect(board.piece_at([0, 4])).to eq(:white_king) <- OBSOLETE
        expect_piece_at([0, 4], King, :white)
      end
    end

    context 'black pawns' do
      it 'places black pawns on row 2' do
        8.times do |column|
          # expect(board.piece_at([6, column])).to eq(:black_pawn) <- OBSOLETE
          piece = board.piece_at([6, column])
          expect(piece).to be_a(Pawn)
          expect(piece.color).to eq(:black)
        end
      end
    end

    context 'black major pieces' do
      it 'places black rooks in the corners of row 8' do
        # expect(board.piece_at([7, 0])).to eq(:black_rook) <- OBSOLETE
          expect_piece_at([7, 0], Rook, :black)

        # expect(board.piece_at([7, 7])).to eq(:black_rook) <- OBSOLETE
          expect_piece_at([7, 7], Rook, :black)
      end

      it 'places black knights next to black rooks' do
        # expect(board.piece_at([7, 1])).to eq(:black_knight) <- OBSOLETE
          expect_piece_at([7, 1], Knight, :black)

          # expect(board.piece_at([7, 6])).to eq(:black_knight) <- OBSOLETE
          expect_piece_at([7, 6], Knight, :black)
      end

      it 'places black bishops next to black knights' do
        # expect(board.piece_at([7, 5])).to eq(:black_bishop) <- OBSOLETE
          expect_piece_at([7, 5], Bishop, :black)

          # expect(board.piece_at([7, 2])).to eq(:black_bishop) <- OBSOLETE
          expect_piece_at([7, 2], Bishop, :black)
      end

      it 'places black queen on middle black square' do
        # expect(board.piece_at([7, 3])).to eq(:black_queen) <- OBSOLETE
          expect_piece_at([7, 3], Queen, :black)
      end

      it 'places black king next to black queen' do
        # expect(board.piece_at([7, 4])).to eq(:black_king) <- OBSOLETE
          expect_piece_at([7, 4], King, :black)
      end
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


  describe '#display_board' do
    it 'renders the current board to the terminal' do
      board.place_starting_pieces
      output = board.display_board
      expect(output).to include("8 | ♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜")
      expect(output).to include("7 | ♟ ♟ ♟ ♟ ♟ ♟ ♟ ♟")
      expect(output).to include("6 |")
      expect(output).to include("5 |")
      expect(output).to include("4 |")
      expect(output).to include("3 |")
      expect(output).to include("2 | ♙ ♙ ♙ ♙ ♙ ♙ ♙ ♙")
      expect(output).to include("1 | ♖ ♘ ♗ ♕ ♔ ♗ ♘ ♖")
      expect(output).to include("  a b c d e f g h")
    end
  end
end