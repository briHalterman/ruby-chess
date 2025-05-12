# spec/pieces/piece_spec.rb
require 'spec_helper'
require_relative '../../lib/pieces/piece'

RSpec.describe Piece do
  let(:piece) { Piece.new(:white, [0, 0]) }

  describe '#symbol' do
    it 'raises NotImplementedError by default' do
      expect { piece.symbol }.to raise_error(NotImplementedError, /must define a `symbol` method/)
    end
  end
end