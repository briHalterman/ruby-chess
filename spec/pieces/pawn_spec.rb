# spec/pieces/pawn_spec.rb
require 'spec_helper'
require_relative '../../lib/pieces/pawn'

RSpec.describe Piece do
  let(:pawn) { Piece.new(:white, [1, 0]) }

  describe '#symbol' do
    it 'returns ♙ for white pawns' do
      expect { piece.symbol }.to eq('♙')
    end
  end
end