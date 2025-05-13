# lib/game.rb
require_relative 'board'

class Game
  attr_reader :board, :current_player

  def initialize
    @board = Board.new
    @board.place_starting_pieces
    @current_player = :white
  end

  def display_board
    puts board.display_board
  end
end