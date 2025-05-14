# lib/pieces/rook.rb
require_relative 'piece'

class Rook < Piece
  def symbol
    color == :white ? '♖' : '♜'
  end

  def valid_move?(from_position, to_position, board)
    from_row, from_column = from_position
    to_row, to_column = to_position

    # Rooks move in straight lines
    return false if from_row != to_row && from_column != to_column
    return false if from_row == to_row && from_column == to_column

    # Determine movement direction
    row_step = to_row <=> from_row
    column_step = to_column <=> from_column

    #Start one square forward
    current_row = from_row + row_step
    current_column = from_column + column_step

    # Check each square until the destination
    while [current_row, current_column] != [to_row, to_column]
    return false unless board.piece_at([current_row, current_column]).nil?
      current_row += row_step
      current_column += column_step
    end

    true
  end
end