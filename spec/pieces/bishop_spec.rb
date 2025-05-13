# spec/pieces/bishop_spec.rb
require 'spec_helper'
require_relative '../../lib/pieces/bishop'

RSpec.describe Bishop do
  let(:white_bishop) { Bishop.new(:white, [0, 2]) }
  let(:black_bishop) { Bishop.new(:black, [7, 2]) }

  describe '#symbol' do
    it 'returns ♗ for white bishops' do
      expect(white_bishop.symbol).to eq('♗')
    end

    it 'returns ♝ for black bishops' do
      expect(black_bishop.symbol).to eq('♝')
    end
  end
end