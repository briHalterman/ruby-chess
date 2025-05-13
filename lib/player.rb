# lib/player.rb
class Player
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def get_move
    print "#{color.capitalize}, enter your move (e.g., e2 e4): "
    gets.chomp
  end
end