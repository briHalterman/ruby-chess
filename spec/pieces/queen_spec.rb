# spec/pieces/queen_spec.rb
require 'spec_helper'
require_relative '../../lib/pieces/queen'

RSpec.describe Queen do
  let(:white_queen) { Queen.new(:white, [0, 4]) }
  let(:black_queen) { Queen.new(:black, [7, 4]) }

  describe '#symbol' do
    it 'returns ♕ for white queens' do
      expect(white_queen.symbol).to eq('♕')
    end

    it 'returns ♛ for black queens' do
      expect(black_queen.symbol).to eq('♛')
    end
  end
end