# spec/pieces/rook_spec.rb
require 'spec_helper'
require_relative '../../lib/pieces/rook'

RSpec.describe Rook do
  let(:white_rook) { Rook.new(:white, [0, 0]) }
  let(:black_rook) { Rook.new(:black, [7, 0]) }

  describe '#symbol' do
    it 'returns ♙ for white rooks' do
      expect(white_rook.symbol).to eq('♖')
    end

    it 'returns ♟ for black rooks' do
      expect(black_rook.symbol).to eq('♜')
    end
  end
end