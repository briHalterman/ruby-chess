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
        mock_piece = double("Piece")
        allow(mock_piece).to receive(:color).and_return(:white)

        allow(game.board).to receive(:piece_at).with(from_position).and_return(mock_piece)
        allow(mock_piece).to receive(:valid_move?).with(from_position, to_position, game.board).and_return(false)

        expect(game.valid_input_format?("e2 e5")).to be false
      end
    end

    context 'when the piece is a pawn do' do
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
        mock_piece = double("Piece", color: :white)

        allow(game.board).to receive(:piece_at).with(from_position).and_return(mock_piece)
        allow(mock_piece).to receive(:valid_move?).with(from_position, to_position, game.board).and_return(true)

        expect(game.valid_input_format?("e2 e3")).to be true
      end

      it 'returns false for a diagonal pawn move when not capturing' do
        from_position = [6, 4]
        to_position = [5, 3]
        mock_piece = double("Piece")
        allow(mock_piece).to receive(:color).and_return(:white)

        allow(game.board).to receive(:piece_at).with(from_position).and_return(mock_piece)
        allow(mock_piece).to receive(:valid_move?).with(from_position, to_position, game.board).and_return(false)

        expect(game.valid_input_format?("e2 d3")).to be false
      end

      it 'returns false if a pawn tries to move backward' do
        from_position = [6, 4]
        to_position = [7, 4]
        mock_piece = double("Piece")
        allow(mock_piece).to receive(:color).and_return(:white)

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
  end
end