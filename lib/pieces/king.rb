# lib/pieces/pawn.rb
require_relative 'piece'

class King < Piece
  def symbol
    color == :white ? '♔' : '♚'
  end

  def valid_move?(from_position, to_position, board)
    row_delta = (to_position[0] - from_position[0]).abs
    column_delta = (to_position[1] - from_position[1]).abs

    row_delta <= 1 && column_delta <= 1 && (row_delta + column_delta != 0)
  end
end