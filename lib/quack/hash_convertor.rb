# Internal: The convertor class to iterate and convert symbol arguments or
# hashes.
class Quack::HashConvertor
  attr_reader :conversion_methods

  # Internal: Initialize a HashConvertor.
  #
  # conversion_methods - The keywords and conversion methods to be used.
  def initialize(conversion_methods)
    @conversion_methods = conversion_methods
  end

  # Internal: Converts the given symbol arguments with the provided conversion
  # methods.
  #
  # argument_hash - The hash with arguments to convert.
  #
  # Examples:
  #
  #   convertor = Quack::HashConvertor.new(word: :to_s, number: :to_i)
  #   convertor.convert!(word: nil, number: "100")
  #   #=> { word: "", number: 100 }
  #
  # Returns an Hash with the converted arguments.
  # Raises Quack::SignatureError if the arguments could not be converted.
  def convert!(argument_hash)
      conversion_methods
        .each_with_object(argument_hash) do |(name, conversion), args|
      args[name] = Quack::DefaultConvertor.new(conversion).convert!(args[name])
    end
  end
end
