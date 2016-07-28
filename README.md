# Lugloc

Simple gem for accessing the LugLoc API (https://api.lugloc.com)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lugloc'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lugloc

## Usage

The gem expects to find your LugLoc account info in ENV:

    ENV['lugloc_api_username'],
    ENV['lugloc_api_password'],
    ENV['lugloc_client_id'],
    ENV['lugloc_secret']

Alternatively, you can pass values in to the methods:

    Lugloc.get_location(
        lugloc_username:    'foo'
        lugloc_password:    'bar'
        lugloc_client_id:   'baz'
        lugloc_secret:      'bap',
        device_id:          'xyz123'
    )
    
## Development

After checking out the repo, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.


### On KWargs

This code uses Ruby 2 style kwargs pervasively. This is just a better, clearer way to write Ruby code.

And it's strictly more expressive (you can supply any of the optional arguments, not just from left to right).

If you're not very clear on how they work, go read up on that.

Common Ruby formatting style has not caught up with kwargs, so you'll notice that the code here is formatted in an unusual manner. This is because once you add keywords to a method call with a few arguments, if you do that on one line:

    foo(first_arg: :first, second_arg: :second, third_arg: third)

It becomes a bit of a jumbled mess to read. The same with the method declaration. Accordingly, both use this sort of style:

    foo(
        first_arg: :first,
        second_arg: :second,
        third_arg: third
    )

KWArgs also offers a great feature where you can receive any extra keyword args with a double splat:

    foo(
        required_arg:,
        optional_arg: nil,
        **c
    )

Here, c will be a hash with any other keywords you cared to supply. This code uses that feature pervasively, and then passes c down to the next function. This means that, say, you can supply any of the optional arguments to call_api in your call to the public methods, and they make their way down to call_api without having to clutter up the code in between with arguments you're just passing on.

This is an unusual style, though, so if you're going to work on the code, you'll just have to get used to it.

I won't accept PRs to change this style.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/AirspaceTechnologies/lugloc.

