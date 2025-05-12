# lib/pieces/rook.rb
require_relative 'piece'

class Rook < Piece
  def symbol
    color == :white ? '♖' : '♜'
  end
end