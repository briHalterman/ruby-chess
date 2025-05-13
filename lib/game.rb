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

  def valid_input_format?(input)
    true
  end
end