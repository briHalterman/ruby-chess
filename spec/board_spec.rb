# spec/board_spec.rb
require 'spec_helper'
require_relative '../lib/board'

RSpec.describe Board do
  describe '#initialize' do
    it 'creates an 8x8 grid' do
      board = Board.new
      expect(board.grid.size).to eq(8)
      expect(board.grid.all? { |row| row.size == 8 }).to be true
    end
  end
end