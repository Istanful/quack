# Internal: The default convertor class to be used in order to convert a single
# argument.
class Quacks::DefaultConvertor
  attr_reader :conversion_method

  # Internal: Initialize a DefaultConvertor.
  #
  # conversion_method - The method to call that does the conversion
  def initialize(conversion_method)
    @conversion_method = conversion_method
  end

  # Internal: Converts the given argument with the conversion method given in the
  # initializer.
  #
  # argument - Any object to convert.
  #
  # Returns the converted argument.
  # Raises Quacks::SignatureError if the argument could not be converted.
  def convert!(argument)
    return argument.public_send(conversion_method) if convertable?(argument)
    raise(Quacks::SignatureError,
          "`#{argument}` must respond to `#{conversion_method}`")
  end

  private

  # Internal: Tells whether the provided argument can be converted or not.
  #
  # Returns a Bool.
  def convertable?(argument)
    argument.respond_to? conversion_method
  end
end
