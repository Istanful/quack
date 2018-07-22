class Quack::DefaultConvertor
  attr_reader :conversion_method

  def initialize(conversion_method)
    @conversion_method = conversion_method
  end

  def convert!(argument)
    return argument.public_send(conversion_method) if argument.respond_to? conversion_method
    raise(Quack::SignatureError, "`#{argument}` must respond to `#{conversion_method}`")
  end
end
