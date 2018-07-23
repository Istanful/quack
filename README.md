# Quacks
Quacks makes ducktyping easy!

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'quack'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install quack

## Usage
To use Quacks you annotate your methods with the `.quacks_like` method.

```ruby
def add(int_a, int_b)
  int_a + int_b
end
quacks_like :add, :to_i, :to_i
```

This will automatically convert the arguments if possible:

```ruby
add('1', 2)
#=> 3
```

If the arguments can not be converted an error will be raised:
```ruby
add(1, {})
#=> Quacks::SignatureError: `{}` must respond to `to_i`.
```

You can force symbol arguments to be converted like so:
```ruby
def divide(int_a, divisor: 2)
  int_a / divisor
end
quacks_like :divide, :to_i, divisor: :to_f
```

If you want to add a signature to a class method you use the singleton class:
```ruby
class Calculator
  def self.add(int_a, int_b)
    int_a + int_b
  end
  singleton_class.quacks_like :add, :int_a, :int_b
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/quack.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
