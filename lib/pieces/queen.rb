# lib/pieces/pawn.rb
require_relative 'piece'

class Queen < Piece
  def symbol
    color == :white ? '♕' : '♛'
  end

  def valid_move?(from_position, to_position, board)
    row_delta = (to_position[0] - from_position[0]).abs
    column_delta = (to_position[1] - from_position[1]).abs

    return true if row_delta == 0 && column_delta > 0
    return true if column_delta == 0 && row_delta > 0
    return true if row_delta == column_delta

    false
  end
end