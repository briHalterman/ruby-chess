# spec/player_spec.rb
require 'spec_helper'
require_relative '../lib/player'

RSpec.describe Player do
  let(:player) { Player.new(:white) }

  describe '#get_move' do
    it 'prompts the player to enter a move and returns it' do
      allow(player).to receive(:gets).and_return("e2 e4\n")
      allow(player).to receive(:print)
      expect(player.get_move).to eq("e2 e4")
    end

    it 'prints a prompt to the player' do
      allow(player).to receive(:gets).and_return("e2 e4\n")

      expect(player).to receive(:print).with(/White, enter your move \(e\.g\., e2 e4\): /)
      player.get_move
    end
  end
end