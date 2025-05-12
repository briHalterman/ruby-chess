# lib/pieces/pawn.rb
require_relative 'piece'

class Knight < Piece
  def symbol
    color == :white ? '♘' : '♞'
  end
end