require 'spec_helper'

RSpec.describe Quacks::HashConvertor do
  it 'converts each argument with the default convertor' do
    convertor = described_class.new(foo: :to_i, bar: :to_s)
    convertor_stub = double(Quacks::DefaultConvertor, convert!: nil)
    allow(Quacks::DefaultConvertor).to receive(:new).and_return(convertor_stub)

    convertor.convert!(foo: '1', bar: 1)

    expect(Quacks::DefaultConvertor).to have_received(:new).with(:to_i)
    expect(Quacks::DefaultConvertor).to have_received(:new).with(:to_s)
    expect(convertor_stub).to have_received(:convert!).with('1')
    expect(convertor_stub).to have_received(:convert!).with(1)
  end
end
