# lib/game.rb
require_relative 'board'
require_relative 'player'
require 'yaml'

class Game
  attr_reader :board, :current_player, :white_player, :black_player

  # Initialization
  def initialize
    @board = Board.new
    @board.place_starting_pieces

    @white_player = Player.new(:white)
    @black_player = Player.new(:black)
    @current_player = @white_player
  end

  def self.new_with_board(board)
    game = Game.allocate
    game.instance_variable_set(:@board, board)
    game.instance_variable_set(:@white_player, Player.new(:white))
    game.instance_variable_set(:@black_player, Player.new(:black))
    game.instance_variable_set(:@current_player, game.white_player)
    game
  end

  # Main Game Loop
  def play
    until game_over?
      play_turn
    end
  end

  def play_turn
    display_board
    puts "#{current_player.color.to_s.capitalize}, your move:"
    move = current_player.get_move.downcase

    case move
    when 'exit'
      puts "Thanks for playing Ruby Chess. Goodbye!"
      exit
    when 'save'
      timestamp = Time.now.strftime('%Y%m%d_%H%M%S')
      file_path = "saves/#{timestamp}.yaml"
      save_game(file_path)
      puts "Game saved to #{file_path}"
      exit
    else
      switch_player if attempt_move(move)
    end
  end

  def switch_player
    @current_player = current_player == white_player ? black_player : white_player
  end

  # User Interaction & Display
  def display_board
    puts board.display_board
  end

  def display_welcome_message
    puts "Let the game begin! White to move. Type 'exit' to leave, or make your move... (e.g., \"e2 e4\")"
  end

  # Move Handling & Validation
  def attempt_move(input)
    return false unless valid_input_format?(input)

    from_str, to_str = input.split
    from_position = parse_position(from_str)
    to_position = parse_position(to_str)

    piece = board.piece_at(from_position)
    target_piece = board.piece_at(to_position)

    if target_piece && target_piece.color == piece.color
      puts "You can't capture your own piece."
      return false
    end

    if move_exposes_king?(from_position, to_position)
      puts "You can't move into check."
      return false
    end

    board.move_piece(from_position, to_position)
    true
  end

  def valid_input_format?(input)
    cells = input.split(" ")
    unless cells.length == 2
      puts "Invalid input format. Use format like 'e2 e4'."
      return false
    end

    unless input =~ /\A[a-h][1-8] [a-h][1-8]\z/
      puts "Invalid input format. Use format like 'e2 e4'."
      return false
    end

    from, _to = cells
    from_position = parse_position(from)
    piece = board.piece_at(from_position)

    if piece.nil?
      puts "No piece at #{from_position}. Please try again."
      return false
    end

    if piece.color != current_player.color
      puts "Wrong color piece, #{piece.color}, for player color, #{current_player.color}. Please try again."
      return false
    end

    to_position = parse_position(_to)
    unless piece.valid_move?(from_position, to_position, board)
      puts "Invalid move for #{piece.class} from #{from_position} to #{to_position}"
      return false
    end

    if move_exposes_king?(from_position, to_position)
      puts "Move exposes king. Please try again."
      return false
    end

    true
  end

  def parse_position(input)
    column = input[0].ord - 'a'.ord
    row = 8 - input[1].to_i
    [row, column]
  end

  # This method is tested indirectly through valid_input_format? and attempt_move
  def move_exposes_king?(from_position, to_position)
    dup_board = deep_dup_board(board)
    dup_board.move_piece(from_position, to_position)
    moved_piece = dup_board.piece_at(to_position)
    moved_piece.position = to_position if moved_piece.respond_to?(:position)
    Game.new_with_board(dup_board).in_check?(current_player.color)
  end

  # Game State Evaluation
  def checkmate?(color)
    return false unless in_check?(color)

    board.grid.each_with_index do |row, row_index|
      row.each_with_index do |piece, column_index|
        next if piece.nil? || piece.color != color

        from_position = [row_index, column_index]

        (0..7).each do |to_row|
          (0..7).each do |to_column|
            to_position = [to_row, to_column]

            next unless piece.valid_move?(from_position, to_position, board)

            dup_board = deep_dup_board(board)
            dup_board.move_piece(from_position, to_position)

            test_game = Game.new_with_board(dup_board)
            return false if !test_game.in_check?(color)
          end
        end
      end
    end

    true
  end

  def in_check?(color)
    king_position = nil

    # Find the king's position
    board.grid.each_with_index do |row, row_index|
      row.each_with_index do |piece, column_index|
        if piece.is_a?(King) && piece.color == color
          king_position = [row_index, column_index]
          break
        end
      end
    end

    return false if king_position.nil?

    # Look for threats from the opposing color
    board.grid.each_with_index do |row, row_index|
      row.each_with_index do |piece, column_index|
        next if piece.nil? || piece.color == color
        return true if piece.valid_move?([row_index, column_index], king_position, board)
      end
    end

    false
  end

  def game_over?
    if checkmate?(:white)
      puts "Checkmate! Black wins!"
      true
    elsif checkmate?(:black)
      puts "Checkmate! White wins!"
      true
    else
      false
    end
  end

  # Save and Load
  def save_game(file_path)
    File.open(file_path, 'w') { |file| file.write(YAML.dump(self)) }
  end

  def self.load_game(file_path)
    YAML.safe_load(
      File.read(file_path),
      permitted_classes: [
        Game, Board, Player,
        Pawn, Rook, Knight, Bishop, Queen, King,
        Symbol, Array, Hash
      ],
      aliases: true
    )
  end

  # Helper Method
  def deep_dup_board(original_board)
    new_board = Board.new
    original_board.grid.each_with_index do |row, row_index|
      row.each_with_index do |piece, column_index|
        if piece
          new_piece = piece.class.new(piece.color, [row_index, column_index])
          new_board.grid[row_index][column_index] = new_piece
        end
      end
    end
    new_board
  end
end