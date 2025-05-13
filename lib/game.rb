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

  def attempt_move(move)

  end

  def play_turn
    move = current_player.get_move
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

    true
  end
end