# lib/pieces/pawn.rb
require_relative 'piece'

class Queen < Piece
  def symbol
    color == :white ? '♕' : '♛'
  end

  def valid_move?(from_position, to_position, board)
    row_delta = (to_position[0] - from_position[0]).abs
    column_delta = (to_position[1] - from_position[1]).abs

    return false if row_delta != 0 && column_delta != 0 && column_delta != 0 && row_delta != column_delta

    row_step = to_position[0] <=> from_position[0]
    column_step = to_position[1] <=> from_position[1]

    current_row, current_column = from_position

    loop do
      current_row += row_step
      current_column += column_step
      break if [current_row, current_column] == to_position

      return false unless board.piece_at([current_row, current_column]).nil?
    end

    true
  end
end