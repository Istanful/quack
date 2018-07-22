require "spec_helper"

RSpec.describe Quack::Quackable do
  describe '.quacks_like' do
    let(:klass) do
      Class.new do
        extend Quack::Quackable
        singleton_class.extend Quack::Quackable

        def add(int_a, int_b)
          int_a + int_b
        end
        quacks_like :add, :to_i, :to_i

        def self.subtract(int_a, int_b)
          int_a - int_b
        end
        singleton_class.quacks_like :subtract, :to_i, :to_i
      end
    end

    it 'adds conversions to the given instance method' do
      instance = klass.new
      stubbed_signature = double(Quack::Signature, apply: [1, 2])
      allow(Quack::Signature).to receive(:new).and_return(stubbed_signature)

      instance.add(1, '2')

      expect(Quack::Signature).to have_received(:new).with(:to_i, :to_i)
      expect(stubbed_signature).to have_received(:apply).with(1, '2')
    end

    it 'adds conversions to the given class method' do
      stubbed_signature = double(Quack::Signature, apply: [1, 2])
      allow(Quack::Signature).to receive(:new).and_return(stubbed_signature)

      klass.subtract(1, '2')

      expect(Quack::Signature).to have_received(:new).with(:to_i, :to_i)
      expect(stubbed_signature).to have_received(:apply).with(1, '2')
    end
  end
end
