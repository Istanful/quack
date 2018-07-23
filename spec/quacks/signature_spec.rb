require "spec_helper"

RSpec.describe Quacks::Signature do
  describe '#apply!' do
    it 'raises if wrong number of arguments given' do
      signature = described_class.new(:to_i, :to_h)

      application = ->{ signature.apply!('foo') }

      expect(application).to raise_error(Quacks::WrongNumberOfArgumentsError)
    end

    context 'when given a symbol argument' do
      it 'uses the hash convertor to convert that argument' do
        signature = described_class.new(foo: :to_i)
        convertor_stub = double(Quacks::HashConvertor, convert!: nil)
        allow(Quacks::HashConvertor).to receive(:new).and_return(convertor_stub)

        signature.apply!(foo: '1')

        expect(Quacks::HashConvertor).to have_received(:new).with(foo: :to_i)
        expect(convertor_stub).to have_received(:convert!).with(foo: '1')
      end
    end

    context 'when given a positional argument' do
      it 'uses the default convertor to convert that argument' do
        signature = described_class.new(:to_i)
        convertor_stub = double(Quacks::DefaultConvertor, convert!: nil)
        allow(Quacks::DefaultConvertor).to receive(:new).and_return(convertor_stub)

        signature.apply!('1')

        expect(Quacks::DefaultConvertor).to have_received(:new).with(:to_i)
        expect(convertor_stub).to have_received(:convert!).with('1')
      end
    end
  end
end
