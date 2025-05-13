# lib/pieces/pawn.rb
require_relative 'piece'

class Knight < Piece
  def symbol
    color == :white ? '♘' : '♞'
  end

  def valid_move?(from_position, to_position, board)
    row_delta = (to_position[1] - from_position[1]).abs
    column_delta = (to_position[0] - from_position[0]).abs

    (row_delta == 2 && column_delta == 1) || (row_delta == 1 && column_delta == 2)
  end
end