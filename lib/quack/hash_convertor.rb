class Quack::HashConvertor
  attr_reader :conversion_methods

  def initialize(conversion_methods)
    @conversion_methods = conversion_methods
  end

  def convert!(argument_hash)
    conversion_methods.each_with_object(argument_hash) do |(name, conversion), args|
      args[name] = Quack::DefaultConvertor.new(conversion).convert!(args[name])
    end
  end
end
