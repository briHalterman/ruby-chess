# lib/pieces/pawn.rb
require_relative 'piece'

class Queen < Piece
  def symbol
    color == :white ? '♕' : '♛'
  end
end