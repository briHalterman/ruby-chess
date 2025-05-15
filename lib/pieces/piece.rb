# lib/pieces/piece.rb
class Piece
  attr_reader :color
  attr_accessor :position

  def initialize(color, position)
    @color = color
    @position = position
  end

  def symbol
    key = "#{color}_#{self.class.name.downcase}".to_sym
    Board::UNICODE_PIECES[key]
  end
end