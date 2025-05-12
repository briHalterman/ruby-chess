# lib/pieces/pawn.rb
require_relative 'piece'

class Pawn < Piece
  def symbol
    return '♙' if color == :white
    return '♟' if color == :black
  end
end