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
    @current_player = :white
  end

  def display_board
    puts board.display_board
  end

  def display_welcome_message
    puts "Let the game begin! White to move. Type 'exit' to leave, or make your move... (e.q., \"e2 e4\")"
  end
end