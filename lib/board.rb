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

  def piece_at(position)
    row, column = position
    @grid[row][column]
  end

  def move_piece(current_position, new_position)
    current_row, current_column = current_position
    new_row, new_column = new_position

    @grid[new_row][new_column] = @grid[current_row][current_column]
    @grid[current_row][current_column] = nil
  end

  def place_starting_pieces
    place_pawns(:white, 1)
    place_major_pieces(:white, 0)
    place_pawns(:black, 6)
    place_major_pieces(:black, 7)
  end

  def place_pawns(color, row)
    8.times do |column|
      place_piece(:"#{color}_pawn", [row, column])
    end
  end

  def place_major_pieces(color, row)
    pieces = [
      :rook, :knight, :bishop, :queen, :king, :bishop, :knight, :rook
    ]

    pieces.each_with_index do |piece, column|
      place_piece(:"#{color}_#{piece}", [row, column])
    end
  end
end