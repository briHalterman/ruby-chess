# lib/pieces/pawn.rb
require_relative 'piece'

class King < Piece
  def symbol
    color == :white ? '♔' : '♚'
  end
end