# lib/pieces/rook.rb
require_relative 'piece'

class Rook < Piece
  def symbol
    color == :white ? '♖' : '♜'
  end

  def valid_move?(from_position, to_position, board)
    row_delta = to_position[0] - from_position[0]
    column_delta = to_position[1] - from_position[1]

    return false if row_delta != 0 && column_delta != 0
    return false if row_delta == 0 && column_delta == 0

    true
  end
end