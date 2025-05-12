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

    # Place white pieces

    # Place 8 white pawns on row 2
    8.times do |column|
      place_piece(:white_pawn, [1, column])
    end

    # Place white rooks in the corners of row 1
    place_piece(:white_rook, [0,0])
    place_piece(:white_rook, [0,7])

    # Place white knights next to white rooks
    place_piece(:white_knight, [0,1])
    place_piece(:white_knight, [0,6])

    # Place white bishops next to white knights
    place_piece(:white_bishop, [0,2])
    place_piece(:white_bishop, [0,5])

    # Place white queen on middle white square
    place_piece(:white_queen, [0,3])

    # Place white king next to white queen
    place_piece(:white_king, [0,4])

    #Place black pieces

    # Place 8 black pawns on row 7
    8.times do |column|
      place_piece(:black_pawn, [6, column])
    end

    # Place black rooks in the corners of row 8
    place_piece(:black_rook, [7,0])
    place_piece(:black_rook, [7,7])

    # Place black knights next to black rooks
    place_piece(:black_knight, [7,1])
    place_piece(:black_knight, [7,6])

    # Place black bishops next to black knights
    place_piece(:black_bishop, [7,2])
    place_piece(:black_bishop, [7,5])

    # Place black queen on middle black square
    place_piece(:black_queen, [7,3])

    # Place black king next to black queen
    place_piece(:black_king, [7,4])
  end
end