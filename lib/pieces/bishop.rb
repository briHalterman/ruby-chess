# lib/pieces/pawn.rb
require_relative 'piece'

class Bishop < Piece
  def symbol
    color == :white ? '♗' : '♝'
  end

  def valid_move?(from_position, to_position, board)
    row_delta = (to_position[0] - from_position[0]).abs
    column_delta = (to_position[1] - from_position[1]).abs

    return false unless row_delta == column_delta

    row_step = (to_position[0] - from_position[0]) <=> 0
    column_step = (to_position[1] - from_position[1]) <=> 0

    current_row = from_position[0] + row_step
    current_column = from_position[1] + column_step

    while [current_row, current_column] != to_position
      return false unless board.piece_at([current_row, current_column]).nil?

      current_row += row_step
      current_column += column_step
    end

    true
  end
end