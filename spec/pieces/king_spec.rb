# spec/pieces/king_spec.rb
require 'spec_helper'
require_relative '../../lib/pieces/king'

RSpec.describe King do
  let(:white_king) { King.new(:white, [0, 3]) }
  let(:black_king) { King.new(:black, [7, 3]) }

  describe '#symbol' do
    it 'returns ♔ for white kings' do
      expect(white_king.symbol).to eq('♔')
    end

    it 'returns ♚ for black kings' do
      expect(black_king.symbol).to eq('♚')
    end
  end
end