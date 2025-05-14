# spec/game_spec.rb
require 'spec_helper'
require_relative '../lib/game'

RSpec.describe Game do
  let(:game) { Game.new }

  describe "#initialize" do
    it 'initializes a board' do
      expect(game.board).to be_a(Board)
    end

    it 'initializes two players' do
      expect(game.white_player).to be_a(Player)
      expect(game.black_player).to be_a(Player)
    end
  end

  describe '#display_board' do
    it 'prints the board to the terminal' do
      expect { game.display_board }.to output(/8 \| ♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜/).to_stdout
    end
  end

  describe '#display_welcome_message' do
    it 'prints a welcome message and instructions to the terminal' do
      expect { game.display_welcome_message }.to output(/Let the game begin! White to move. Type 'exit' to leave, or make your move... \(e\.q\., "e2 e4"\)/).to_stdout
    end
  end

  describe '#play_turn' do
    it 'gets input and attempts to move a piece' do
      allow(game.current_player).to receive(:get_move).and_return("e2 e4")
      allow(game).to receive(:attempt_move)
      game.play_turn
      expect(game).to have_received(:attempt_move).with("e2 e4")
    end

    it 'exits the game when player types "exit"' do
      game = Game.new
      allow(game.current_player).to receive(:get_move).and_return("exit")

      expect { game.play_turn }.to raise_error(SystemExit)
    end

    it 'displays the board each turn' do
      allow(game.current_player).to receive(:get_move).and_return("e2 e4")
      allow(game).to receive(:attempt_move)

      expect(game).to receive(:display_board)
      game.play_turn
    end
  end

  describe '#valid_input_format?' do
    let(:mock_piece) { double("Piece", color: :white) }
    let(:current_player) { double("Player", color: :white) }
    let(:black_piece) { double("Piece", color: :black)}

    before do
      allow(game).to receive(:current_player).and_return(current_player)
    end

    context 'general input validation (all pieces)' do
      it 'returns false for invalid input like "knight to e4"' do
        expect(game.valid_input_format?("knight to e4")).to be false
      end

      it 'returns false for inputs with squares off the board' do
        expect(game.valid_input_format?("z9 e4")).to be false
        expect(game.valid_input_format?("e2 i3")).to be false
        expect(game.valid_input_format?("a0 b9")).to be false
        expect(game.valid_input_format?("h9 h2")).to be false
      end

      it 'returns false if the source square has no piece' do
        allow(game.board).to receive(:piece_at).with([5, 4]).and_return(nil)
        expect(game.valid_input_format?("e3 e4")).to be false
      end

      it 'returns false if the piece does not belong to the current player' do
        allow(game.board).to receive(:piece_at).with([5, 4]).and_return(black_piece)

        expect(game.valid_input_format?("e3 e4")).to be false
      end

      it 'returns false if the piece cannot legally move to the destination cell' do
        from_position = [6, 4]
        to_position = [3, 4]

        allow(game.board).to receive(:piece_at).with(from_position).and_return(mock_piece)
        allow(mock_piece).to receive(:valid_move?).with(from_position, to_position, game.board).and_return(false)

        expect(game.valid_input_format?("e2 e5")).to be false
      end
    end

    context 'when the piece is a pawn' do
      it 'returns true for valid format like "e2 e4"' do
        from_position = [6, 4]
        to_position = [4, 4]

        allow(game.board).to receive(:piece_at).with(from_position).and_return(mock_piece)
        allow(mock_piece).to receive(:valid_move?).with(from_position, to_position, game.board).and_return(true)

        expect(game.valid_input_format?("e2 e4")).to be true
      end


      it 'returns true if the piece can legally move to the destination cell' do
        from_position = [6, 4]
        to_position = [5, 4]
\
        allow(game.board).to receive(:piece_at).with(from_position).and_return(mock_piece)
        allow(mock_piece).to receive(:valid_move?).with(from_position, to_position, game.board).and_return(true)

        expect(game.valid_input_format?("e2 e3")).to be true
      end

      it 'returns false for a diagonal pawn move when not capturing' do
        from_position = [6, 4]
        to_position = [5, 3]

        allow(game.board).to receive(:piece_at).with(from_position).and_return(mock_piece)
        allow(mock_piece).to receive(:valid_move?).with(from_position, to_position, game.board).and_return(false)

        expect(game.valid_input_format?("e2 d3")).to be false
      end

      it 'returns false if a pawn tries to move backward' do
        from_position = [6, 4]
        to_position = [7, 4]

        allow(game.board).to receive(:piece_at).with(from_position).and_return(mock_piece)
        allow(mock_piece).to receive(:valid_move?).with(from_position, to_position, game.board).and_return(false)

        expect(game.valid_input_format?("e2 e1")).to be false
      end
    end

    context 'when the piece is a rook' do
      it 'returns true for a valid rook move' do
        from_position = [7, 7]
        to_position = [4, 7]

        rook = double("Rook", color: :white)
        allow(game.board).to receive(:piece_at).with(from_position).and_return(rook)
        allow(rook).to receive(:valid_move?).with(from_position, to_position, game.board).and_return(true)

        expect(game.valid_input_format?("h1 h4")).to be true
      end

      it 'returns false for an invalid rook move' do
        from_position = [7, 7]
        to_position = [6, 6]

        rook = double("Rook", color: :white)
        allow(game.board).to receive(:piece_at).with(from_position).and_return(rook)
        allow(rook).to receive(:valid_move?).with(from_position, to_position, game.board).and_return(false)

        expect(game.valid_input_format?("h1 g2")).to be false
      end
    end

    context 'when the piece is a knight' do
      let(:knight) { double("Knight", color: :white) }

      it 'returns true for a valid knight move' do
        from_position = [7, 6]
        to_position = [5, 5]

        knight = double("Knight", color: :white)
        allow(game.board).to receive(:piece_at).with(from_position).and_return(knight)
        allow(knight).to receive(:valid_move?).with(from_position, to_position, game.board).and_return(true)

        expect(game.valid_input_format?("g1 f3")).to be true
      end

      it 'returns false for an invalid knight move' do
        from_position = [7, 6]
        to_position = [6, 6]

        allow(game.board).to receive(:piece_at).with(from_position).and_return(knight)
        allow(knight).to receive(:valid_move?).with(from_position, to_position, game.board).and_return(false)

        expect(game.valid_input_format?("g1 g2")).to be false
      end
    end

    context 'when piece is a bishop' do
      it 'returns true for a valid bishop move' do
        from_position = [7, 2]
        to_position = [4, 5]

        bishop = double("Bishop", color: :white)
        allow(game.board).to receive(:piece_at).with(from_position).and_return(bishop)
        allow(bishop).to receive(:valid_move?).with(from_position, to_position, game.board).and_return(true)

        expect(game.valid_input_format?("c1 f4")).to be true
      end

      it 'returns false for an invalid bishop move' do
        from_position = [7, 2] # c1
        to_position = [7, 3]   # d1 (not diagonal)

        bishop = double("Bishop", color: :white)
        allow(game.board).to receive(:piece_at).with(from_position).and_return(bishop)
        allow(bishop).to receive(:valid_move?).with(from_position, to_position, game.board).and_return(false)

        expect(game.valid_input_format?("c1 d1")).to be false
      end
    end

    context 'when piece is a queen' do
      it 'returns true for a valid vertical queen move' do
        from_position = [7, 3]
        to_position = [4, 3]
        queen = double("Queen", color: :white)

        allow(game.board).to receive(:piece_at).with(from_position).and_return(queen)
        allow(queen).to receive(:valid_move?).with(from_position, to_position, game.board).and_return(true)

        expect(game.valid_input_format?("d1 d4")).to be true
      end

      it 'returns true for a valid diagonal queen move' do
        from_position = [7, 3]
        to_position = [4, 6]
        queen = double("Queen", color: :white)

        allow(game.board).to receive(:piece_at).with(from_position).and_return(queen)
        allow(queen).to receive(:valid_move?).with(from_position, to_position, game.board).and_return(true)

        expect(game.valid_input_format?("d1 g4")).to be true
      end

      it 'returns false for an invalid queen move' do
        from_position = [7, 3]
        to_position = [6, 5]
        queen = double("Queen", color: :white)

        allow(game.board).to receive(:piece_at).with(from_position).and_return(queen)
        allow(queen).to receive(:valid_move?).with(from_position, to_position, game.board).and_return(false)

        expect(game.valid_input_format?("d1 f2")).to be false
      end
    end

    context 'when piece is a king' do
      it 'returns true for a valid king move' do
        from_position = [7, 4]
        to_position = [6, 4]

        king = double("King", color: :white)
        allow(game.board).to receive(:piece_at).with(from_position).and_return(king)
        allow(king).to receive(:valid_move?).with(from_position, to_position, game.board).and_return(true)

        expect(game.valid_input_format?("e1 e2")).to be true
      end

      it 'returns false for an invalid king move' do
        from_position = [7, 4]
        to_position = [5, 4]

        king = double("King", color: :white)
        allow(game.board).to receive(:piece_at).with(from_position).and_return(king)
        allow(king).to receive(:valid_move?).with(from_position, to_position, game.board).and_return(false)

        expect(game.valid_input_format?("e1 e3")).to be false
      end
    end

    context 'self-check prevention' do
      it 'returns false if a move would leave the king in check' do
        game = Game.new_with_board(Board.new)
        board = game.board
        board.clear!

        white_king = King.new(:white, [7, 4])
        white_rook = Rook.new(:white, [7, 3])
        black_rook = Rook.new(:black, [7, 0])

        board.place_piece(white_king, [7, 4])
        board.place_piece(white_rook, [7, 3])
        board.place_piece(black_rook, [7, 0])

        allow(game).to receive(:current_player).and_return(game.white_player)

        expect(game.valid_input_format?("d1 d2")).to be false
      end

      it 'returns true if a move does not leave the king check' do
        game = Game.new
        board = game.board
        board.clear!

        white_king = King.new(:white, [7, 4])
        white_rook = Rook.new(:white, [7, 3])
        black_rook = Rook.new(:black, [6, 0])

        board.place_piece(white_king, [7, 4])
        board.place_piece(white_rook, [7, 3])
        board.place_piece(black_rook, [6, 0])

        allow(game).to receive(:current_player).and_return(game.white_player)

        expect(game.valid_input_format?("d1 d2")).to be true
      end
    end
  end

  describe '#attempt_move' do
    let(:game) { Game.new }

    before do
      allow(game).to receive(:puts)
    end

    it 'rejects invalid input' do
      allow(game).to receive(:valid_input_format?).with("e9 e4").and_return(false)
      expect(game.board).not_to receive(:move_piece)

      game.attempt_move("e9 e4")
    end

    it 'moves the piece for valid input' do
      from_position = [6, 4]
      to_position = [4, 4]

      allow(game).to receive(:valid_input_format?).with("e2 e4").and_return(true)
      allow(game).to receive(:parse_position).with("e2").and_return(from_position)
      allow(game).to receive(:parse_position).with("e4").and_return(to_position)
      expect(game.board).to receive(:move_piece).with(from_position, to_position)

      game.attempt_move("e2 e4")
    end

    it 'does not allow capturing you own piece' do
      input = "e2 e1"
      from_position = [6, 4]
      to_position = [7, 4]

      own_piece = double("Piece", color: :white)
      target_piece = double("Piece", color: :white)

      allow(game).to receive(:valid_input_format?).with(input).and_return(true)
      allow(game.board).to receive(:piece_at).with(from_position).and_return(own_piece)
      allow(game.board).to receive(:piece_at).with(to_position).and_return(target_piece)

      expect(game.board).not_to receive(:move_piece)

      game.attempt_move(input)
    end

    it 'replaces an opponent\'s piece with the moving piece when captured' do
      from_position = [6, 4]
      to_position = [1, 4]
      moving_piece = double("Piece", color: :white)
      opponent_piece = double("Piece", color: :black)

      allow(game.board).to receive(:piece_at).with(from_position).and_return(moving_piece)
      allow(game.board).to receive(:piece_at).with(to_position).and_return(opponent_piece)
      allow(moving_piece).to receive(:valid_move?).with(from_position, to_position, game.board).and_return(true)
      allow(game).to receive(:current_player).and_return(double("Player", color: :white))

      expect(game.board).to receive(:move_piece).with(from_position, to_position)
      allow(game).to receive(:move_exposes_king?).and_return(false)
      game.attempt_move("e2 e7")
    end
  end

  describe '#play' do
    it 'calls play_turn repeatedly until the game is over' do
      game = Game.new

      allow(game).to receive(:play_turn)
      allow(game).to receive(:game_over?).and_return(false, false, true)

      game.play

      expect(game).to have_received(:play_turn).exactly(2).times
    end
  end

  describe '#switch_player' do
    it 'switches from white to black' do
      game = Game.new
      expect { game.send(:switch_player) }.to change { game.current_player.color }.from(:white).to(:black)
    end
  end

  describe '#in_check?' do
    it 'returns true when the white king is under attack' do
      game = Game.new
      board = game.board

      # Clear board and set up just the white king and black rook
      board.clear!
      white_king = King.new(:white, [0, 4])
      black_rook = Rook.new(:black, [1, 4])

      board.place_piece(white_king, [0, 4])
      board.place_piece(black_rook, [1, 4])

      expect(game.in_check?(:white)).to be true
    end

    it 'returns false when the king is safe' do
      game = Game.new
      board = game.board

      board.clear!
      white_king = King.new(:white, [0, 4])
      black_rook = Rook.new(:black, [1, 5]) # not attacking king

      board.place_piece(white_king, [0, 4])
      board.place_piece(black_rook, [1, 5])

      expect(game.in_check?(:white)).to be false
    end
  end

  describe '#checkmate?' do
    it 'returns true when the current player is in checkmate' do
      game = Game.new
      board = game.board
      board.clear!

      white_king = King.new(:white, [7, 7])
      black_rook1 = Rook.new(:black, [7, 6])
      black_rook2 = Rook.new(:black, [6, 7])

      board.place_piece(white_king, [7, 7])
      board.place_piece(black_rook1, [6, 6])
      board.place_piece(black_rook2, [6, 7])

      allow(game).to receive(:current_player).and_return(game.white_player)

      expect(game.checkmate?(:white)).to be true
    end
  end

  describe '#game_over?' do
    it 'returns true when white is in checkmate' do
      game = Game.new
      board = game.board
      board.clear!

      white_king = King.new(:white, [7, 7])
      black_rook1 = Rook.new(:black, [7, 6])
      black_rook2 = Rook.new(:black, [6, 7])

      board.place_piece(white_king, [7, 7])
      board.place_piece(black_rook1, [6, 6])
      board.place_piece(black_rook2, [6, 7])

      allow(game).to receive(:current_player).and_return(game.white_player)

      expect(game.game_over?).to be true
    end
  end
end