require 'default_values/version'
require 'default_values/dsl'
require 'default_values/railtie' if defined?(Rails)

#
# = ActiveRecord::DefaultValue
# initialize with default_values
#
# == sample
# you can specify default values with hash:
#
#  class Book < ActiveRecord::Base
#    default_values rating: 'r18', type: 'comic'
#  end
#
#  book = Book.new
#  book.rating # => "r18"
#  book.type # => "comic"
#  book.title # => nil
#
# you can use instance values with lambda:
#  class Book < ActiveRecord::Base
#    default_values type: 'comic', released_at: lambda { Time.now }
#  end
#
# or with block:
#  class Book < ActiveRecord::Base
#    default_values type: 'comic' do
#      t = Time.now
#      {released_at: t, edition_updated_at: t}
#    end
#  end
#
#  book1 = Book.new
#  # wait 10 sec
#  book2 = Book.new
#  book1.release_at == book2.release_at # => false
#  book1.released_at == book1.edition_updated_at # => true
#
module DefaultValues
end
