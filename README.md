[![Gem Version](https://badge.fury.io/rb/bunny_cdn.svg)](https://badge.fury.io/rb/bunny_cdn)
[![Codeship Status for brandon-meeks/bunny_cdn](https://app.codeship.com/projects/7f94a660-529a-0138-70bd-36e3badc0e07/status?branch=master)](https://app.codeship.com/projects/401801)
[![Maintainability](https://api.codeclimate.com/v1/badges/2cc8e5b9529c32d7473f/maintainability)](https://codeclimate.com/github/brandon-meeks/bunny_cdn/maintainability)

# BunnyCdn

This gem allows you to interact with the Bunny CDN API. Currently you can interact with the Storage and Pullzone APIs.

This does require you to have an account with [BunnyCDN](https://bunnycdn.com/).

## Notes 

* This is an updated version of the original `bunny_cdn` gemfile [created by @brandon-meeks](brandon-meeks/bunny_cdn). 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bunny_cdn', git: 'https://github.com/johlym/bunny_cdn'
```

And then execute:

```sh
$ bundle
```

Or install it yourself with:

```sh
git clone https://github.com/johlym/bunny_cdn
cd bunny_cdn
gem build bunny_cdn.gemspec
gem install bunny_cdn-VERSION.gemspec
```

(where `VERSION` is the version number built.)

## Usage

### Rails

Create the initializer `config/initializers/bunny_cdn.rb` and set the configuration options.

```ruby
BunnyCdn.configure do |config|
    config.api_key = # The API key for your BunnyCDN account
    config.storage_zone = # The storage zone you want to work with
    config.access_key = # The password for your storage zone
    config.region = # The region in which the storage zone was originally created. If this is not set or is set to `eu`, the Gem will use the EU zone.
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/johlym/bunny_cdn. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the BunnyCdn project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/johlym/bunny_cdn/blob/master/CODE_OF_CONDUCT.md).
