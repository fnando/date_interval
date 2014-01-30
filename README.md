# DateInterval

Parse date intervals from strings.

## Installation

Add this line to your application's Gemfile:

    gem 'date_interval'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install date_interval

## Usage

You must always define at least one range at the beginning of the expression. The snippet below will return three dates objects.

```ruby
expr = "2014-01-01 - 2014-01-03"
dates = DateInterval.parse(expr)
```

You can provide as many intervals as you want. The following expression returns six date objects.

```ruby
expr = "2014-01-01 - 2014-01-03, 2014-02-01 - 2014-02-03"
dates = DateInterval.parse(expr)
```

You can also define filters. Filters are applied in sequence, from left to right. The following filters are available:

- `none`: return no dates. Useful for applying specific filters afterwards.
- `[+-]weekends`: filter weekend dates
- `[+-]weekdays`: filter weekdays ()
- `[+-]sundays`: filter sundays. You can use any weekday name (sundays-saturdays)
- `[+-]yyy-mm-dd`: add/remove the given date.

Beware that duplicated dates are removed from the final result. They're also sorted.

## Contributing

1. Fork it ( http://github.com/[my-github-username]/date_interval/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
