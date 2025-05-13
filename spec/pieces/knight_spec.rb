# spec/pieces/knight_spec.rb
require 'spec_helper'
require_relative '../../lib/pieces/knight'

RSpec.describe Knight do
  let(:white_knight) { Knight.new(:white, [0, 1]) }
  let(:black_knight) { Knight.new(:black, [7, 1]) }

  describe '#symbol' do
    it 'returns ♘ for white knights' do
      expect(white_knight.symbol).to eq('♘')
    end

    it 'returns ♞ for black knights' do
      expect(black_knight.symbol).to eq('♞')
    end
  end
end