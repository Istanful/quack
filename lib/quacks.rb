require "quacks/version"
require "quacks/signature"
require "quacks/default_convertor"
require "quacks/hash_convertor"
require "quacks/error"
require "quacks/signature_error"
require "quacks/wrong_number_of_arguments_error"
require "quacks/quackable"

module Quacks
end

class Object
  extend Quacks::Quackable
  singleton_class.extend Quacks::Quackable
end
