# lib/pieces/pawn.rb
require_relative 'piece'

class Bishop < Piece
  def symbol
    color == :white ? '♗' : '♝'
  end
end