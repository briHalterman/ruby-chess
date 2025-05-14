# lib/game.rb
require_relative 'board'
require_relative 'player'

class Game
  attr_reader :board, :current_player, :white_player, :black_player

  def initialize
    @board = Board.new
    @board.place_starting_pieces
    @white_player = Player.new(:white)
    @black_player = Player.new(:black)
    @current_player = @white_player
  end

  def display_board
    puts board.display_board
  end

  def display_welcome_message
    puts "Let the game begin! White to move. Type 'exit' to leave, or make your move... (e.q., \"e2 e4\")"
  end

  def attempt_move(input)
    if valid_input_format?(input)
      from_str, to_str = input.split
      from_position = parse_position(from_str)
      to_position = parse_position(to_str)

      piece = board.piece_at(from_position)
      target_piece = board.piece_at(to_position)

      if target_piece && target_piece.color == piece.color
        puts "You can't capture your own piece."
        return
      end

      if move_exposes_king?(from_position, to_position)
        puts "You can't move into check"
        return
      end

      board.move_piece(from_position, to_position)
    else
      puts "Invalid move. Please try again."
    end

  end

  def play_turn
    display_board
    puts "#{current_player.color.to_s.capitalize}, your move:"
    move = current_player.get_move
    exit if move.downcase == 'exit'
    attempt_move(move)
    switch_player
  end

  def parse_position(cell)
    column = cell[0].ord - 'a'.ord
    row = 8 - cell[1].to_i
    [row, column]
  end

  def valid_input_format?(input)
    cells = input.split(" ")
    return false unless cells.length == 2
    return false unless input =~ /\A[a-h][1-8] [a-h][1-8]\z/

    from, _to = cells
    from_position = parse_position(from)
    piece = board.piece_at(from_position)
    return false if piece.nil?
    return false unless piece.color == current_player.color

    to_position = parse_position(_to)
    return false unless piece.valid_move?(from_position, to_position, board)

    return false if move_exposes_king?(from_position, to_position)

    true
  end

  def play
    until game_over?
      play_turn
    end
  end

  def switch_player
    @current_player = current_player == white_player ? black_player : white_player
  end

  def in_check?(color)
    king_position = nil

    # Find the king's position
    board.grid.each_with_index do |row, row_index|
      row.each_with_index do |piece, column_index|
        if piece.is_a?(King) && piece.color == color
          king_position = [row_index, column_index]
          break
        end
      end
    end

    return false if king_position.nil?

    # Look for threats from the opposing color
    board.grid.each_with_index do |row, row_index|
      row.each_with_index do |piece, column_index|
        next if piece.nil? || piece.color == color
        return true if piece.valid_move?([row_index, column_index], king_position, board)
      end
    end

    false
  end

  def move_exposes_king?(from_position, to_position)
    dup_board = deep_dup_board(board)
    dup_board.move_piece(from_position, to_position)
    moved_piece = dup_board.piece_at(to_position)
    moved_piece.position = to_position if moved_piece.respond_to?(:position)
    Game.new_with_board(dup_board).in_check?(current_player.color)
  end

  def deep_dup_board(original_board)
    new_board = Board.new
    original_board.grid.each_with_index do |row, row_index|
      row.each_with_index do |piece, column_index|
        if piece
          new_piece = piece.class.new(piece.color, [row_index, column_index])
          new_board.grid[row_index][column_index] = new_piece
        end
      end
    end
    new_board
  end

  def self.new_with_board(board)
    game = Game.allocate
    game.instance_variable_set(:@board, board)
    game.instance_variable_set(:@white_player, Player.new(:white))
    game.instance_variable_set(:@black_player, Player.new(:black))
    game.instance_variable_set(:@current_player, game.white_player)
    game
  end

  def game_over?
    false
  end
end