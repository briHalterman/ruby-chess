# lib/board.rb
require_relative 'pieces/pawn'
require_relative 'pieces/rook'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/queen'
require_relative 'pieces/king'
class Board
  UNICODE_PIECES = {
    white_pawn: '♙', white_rook: '♖', white_knight: '♘', white_bishop: '♗', white_queen: '♕', white_king: '♔',
    black_pawn: '♟', black_rook: '♜', black_knight: '♞', black_bishop: '♝', black_queen: '♛', black_king: '♚'
  }

  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def place_piece(piece, position)
    row, column = position
    @grid[row][column] = piece
  end

  def piece_at(position)
    row, column = position
    @grid[row][column]
  end

  def move_piece(current_position, new_position)
    piece = piece_at(current_position)
    piece.position = new_position if piece
    place_piece(piece, new_position)
    place_piece(nil, current_position)
  end

  def place_starting_pieces
    place_major_pieces(:black, 0)
    place_pawns(:black, 1)
    place_pawns(:white, 6)
    place_major_pieces(:white, 7)
  end

  def place_pawns(color, row)
    8.times do |column|
      place_piece(Pawn.new(color, [row, column]), [row, column])
    end
  end

  def place_major_pieces(color, row)
    piece_classes = {
      rook: Rook,
      knight: Knight,
      bishop: Bishop,
      queen: Queen,
      king: King
    }

    order = [:rook, :knight, :bishop, :queen, :king, :bishop, :knight, :rook]

    order.each_with_index do |piece, column|
      klass = piece_classes[piece]
      place_piece(klass.new(color, [row, column]), [row, column])
    end
  end

  def display_board
    rows = @grid.each_with_index.map do |row, i|
      pieces = row.map { |cell| cell&.symbol || ' ' }
      "#{8 - i} | #{pieces.join(' ')}"
    end
    rows << "    a b c d e f g h"
    rows.join("\n")
  end

  # Reset the board to an empty state
  def clear!
    @grid = Array.new(8) { Array.new(8, nil) }
  end
end