# lib/game.rb
require_relative 'board'

class Game
  attr_reader :board, :current_player

  def initialize
    @board = Board.new
    @current_player = :white
  end
end