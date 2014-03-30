# DataURL

DataURL helps you parse and create data: URLs.

## Installation

Add this line to your application's Gemfile:

    gem 'data_url'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install data_url

## Usage

The `DataURL` module has two methods. `parse` is used to parse the data and other information out of a data URL:

    data, content_type, base64 = DataURL.parse(data_url)
    # Feel free to ignore the base64 return value

The other, `create`, generates a data URL containing the data and other information you want it to include:

    data_url = DataURL.create(data, content_type, base64)
    # Last two parameters default to 'application/octet-stream' and 'true'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
