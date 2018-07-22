class Quack::Signature
  attr_reader :signature

  def initialize(*signature)
    @signature = signature
  end

  def apply(*args)
    validate args, signature
    signature.each_with_index.map do |arg_signature, i|
      convert! args[i], arg_signature
    end
  end

  private

  def convertor_for(conversion)
    convertor_class(conversion).new(conversion)
  end

  def convertor_class(conversion)
    case conversion
    when Hash
      Quack::HashConvertor
    else
      Quack::DefaultConvertor
    end
  end

  def convert!(arguments, conversion)
    convertor_for(conversion).convert!(arguments)
  end

  def validate(arguments, signature)
    return true if arguments.length == signature.length
    raise Quack::WrongNumberOfArgumentsError
  end
end
