# Internal: The class responsible for massaging parameters before passing them
# to the signatured method.
class Quack::Signature
  attr_reader :signature

  # Internal: Initialize a signature object.
  #
  # signature - The Symbol or Hash conversion method(s) that depicts this
  #   signature.
  def initialize(*signature)
    @signature = signature
  end

  # Internal: Convert the given arguments, with the given conversion methods.
  #
  # Examples:
  #
  #   Quack::Signature.new(:to_i, bignum: :to_s).apply!('1', 100)
  #   #=> [1, { bignum: '100' }]
  #
  # Returns an Array of arguments.
  # Raises Quack::SignatureError if the arguments could not be converted.
  # Raises Quack::WrongNumberOfArgumentsError if wrong number of arguments.
  def apply!(*args)
    validate args, signature
    signature.each_with_index.map do |arg_signature, i|
      convert! args[i], arg_signature
    end
  end

  private

  # Internal: Returns a convertor to perform the given conversion.
  #
  # conversion - An Hash with conversions or a Symbol conversion.
  #
  # Returns a Quack::HashConvertor or Quack::DefaultConvertor instance.
  def convertor_for(conversion)
    convertor_class(conversion).new(conversion)
  end

  # Internal: Returns the class to be used for applying the given conversion.
  #
  # conversion = An Hash with conversions or a Symbol conversion.
  def convertor_class(conversion)
    case conversion
    when Hash
      Quack::HashConvertor
    else
      Quack::DefaultConvertor
    end
  end

  # Internal: Converts the given arguments with the given conversion(s).
  #
  #
  # arguments - The Hash symbol arguments or any Object to convert.
  # conversion = An Hash with conversions or a Symbol conversion.
  #
  # Returns the converted argument.
  def convert!(arguments, conversion)
    convertor_for(conversion).convert!(arguments)
  end

  # Internal: Determine if correct number of arguments were given.
  #
  # Returns true if correct number of arguments.
  # Raises Quack::WrongNumberOfArgumentsError if wrong number of arguments
  #   given.
  def validate(arguments, signature)
    return true if arguments.length == signature.length
    raise Quack::WrongNumberOfArgumentsError
  end
end
