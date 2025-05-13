# spec/game_spec.rb
require 'spec_helper'
require_relative '../lib/game'

RSpec.describe Game do
  let(:game) { Game.new }

  describe "#initialize" do
    it 'initializes a board' do
      expect(game.board).to be_a(Board)
    end
  end

  describe '#display_board' do
    it 'prints the board to the terminal' do
      game = Game.new
      expect { game.display_board }.to output(/8 \| ♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜/).to_stdout
    end
  end
end