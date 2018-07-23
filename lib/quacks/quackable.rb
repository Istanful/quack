# Public: Concern to be extended in order to enable the quacks like method.
module Quacks::Quackable
  # Public: Force the given method to use the given conversions for its
  # arguments.
  #
  # Examples
  #   class Calculator
  #     def add(int_a, int_b)
  #       int_a + int_b
  #     end
  #     quacks_like :add, :to_i, :to_i
  #   end
  #
  #   # Supported arguments will be converted accordingly.
  #   Calculator.new.add(1, '2')
  #   #=> 3
  #
  #   # Unspported arguments will raise an error
  #   Calculator.new.add(1, {})
  #   #=> SignatureError: Expected `{}` to respond to `to_i`.
  #
  #   # To add signatures to class methods you can use the singleton class.
  #   class Calculator
  #     singleton_class.extend(Quacks::Quackable)
  #
  #     def self.add(int_a, int_b)
  #       int_a + int_b
  #     end
  #     singleton_class.quacks_like :add, :to_i, :to_i
  #   end
  #
  # Returns the Symbol method name.
  def quacks_like(method_name, *signature_args)
    alias_method "orig_#{method_name}", method_name
    define_method(method_name) do |*args|
      signature = Quacks::Signature.new(*signature_args)
      send("orig_#{method_name}", *signature.apply!(*args))
    end
  end
end
