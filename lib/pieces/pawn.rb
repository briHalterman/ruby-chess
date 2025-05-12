# lib/pieces/pawn.rb
require_relative 'piece'

class Pawn < Piece
  def symbol
    color == :white ? '♙' : '♟'
  end
end