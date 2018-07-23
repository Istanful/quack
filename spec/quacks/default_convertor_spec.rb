require 'spec_helper'

RSpec.describe Quacks::DefaultConvertor do
  context 'when given a valid argument' do
    it 'converts that argument with the given conversion method' do
      convertor = described_class.new(:to_i)

      result = convertor.convert!('1')

      expect(result).to eq(1)
    end
  end

  context 'when given an invalid argument' do
    it 'raises a signature error' do
      convertor = described_class.new(:to_i)

      application = ->{ convertor.convert!({}) }

      expect(application).to raise_error(Quacks::SignatureError)
    end
  end
end
