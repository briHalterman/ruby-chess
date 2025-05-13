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

      board.move_piece(from_position, to_position)
    else
      puts "Invalid move. Please try again."
    end
  end

  def play_turn
    display_board
    move = current_player.get_move
    exit if move.downcase == 'exit'
    attempt_move(move)
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

    true
  end

  def play
    until game_over?
      play_turn
    end
  end

  def game_over?
    false
  end
end