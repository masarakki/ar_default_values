# DefaultValues

initialize with default_values

## Installation

Add this line to your application's Gemfile:

    gem 'ar_default_values'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ar_default_values

## Usage

you can specify default values with hash:

```ruby
class Book < ActiveRecord::Base
  default_values rating: 'r18', type: 'comic' do
    t = Time.now
    { :released_at => t, :edition_updated_at => t }
  end
end

book = Book.new
book.rating # => "r18"
book.type # => "comic"
book.title # => nil
book.released_at == book.edition_updated_at # => true
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
