# lib/board.rb
class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def place_piece(piece, position)
    row, column = position
    @grid[row][column] = piece
  end
end