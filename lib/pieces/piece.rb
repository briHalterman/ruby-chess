# lib/pieces/piece.rb
class Piece
  attr_reader :color
  attr_accessor :position

  def initialize(color, position)
    @color = color
    @position = position
  end

  def symbol
    raise NotImplementedError, 'Each subclass must define a `symbol` method.'
  end
end