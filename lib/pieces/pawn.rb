# lib/pieces/pawn.rb
require_relative 'piece'

class Pawn < Piece
  def symbol
    color == :white ? '♙' : '♟'
  end

  def valid_move?(from_position, to_position, board)
    direction = color == :white ? -1 : 1
    start_row = color == :white ? 6 : 1

    row_delta = to_position[0] - from_position[0]
    column_delta = (to_position[1] - from_position[1]).abs

    # Capturing diagonally
    if row_delta == direction && column_delta == 1
      target = board.piece_at(to_position)
      return false unless target
      return target.color != color
    end

    # Pawns don't move sideways
    return false unless column_delta == 0

    if color == :white
      return true if row_delta == -1 # One square forward
      return true if from_position[0] == 6 && row_delta == -2 # Opening two-square move
    else
      return true if row_delta == 1
      return true if from_position[0] == 1 && row_delta == 2
    end
  end
end