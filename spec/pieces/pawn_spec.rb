# spec/pieces/pawn_spec.rb
require 'spec_helper'
require_relative '../../lib/pieces/pawn'

RSpec.describe Pawn do
  let(:white_pawn) { Pawn.new(:white, [1, 0]) }

  describe '#symbol' do
    it 'returns ♙ for white pawns' do
      expect(white_pawn.symbol).to eq('♙')
    end
  end
end