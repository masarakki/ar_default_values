require 'active_support'
require 'active_record'

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
module ActiveRecord
  module DefaultValue
    extend ActiveSupport::Concern

    module ClassMethods
      def default_values(defaults = {}, &block)
        define_method(:initialize_with_default_values) do |*attributes, &inner_block|
          defaults = defaults.merge(block.call) if block_given?
          defaults = Hash[defaults.each_pair.map{ |key, value| [key, value.kind_of?(Proc) ? value.call : value]}]
          authorizer = self.mass_assignment_authorizer(nil)

          parted_defaults = defaults.partition do |key, value|
            authorizer.deny?(key)
          end

          sanitized_defaults = Hash[parted_defaults[1]]
          protected_defaults = Hash[parted_defaults[0]]

          attributes[0] = sanitized_defaults.merge(attributes.first || {})
          initialize_without_default_values(*attributes, &inner_block)
          protected_defaults.each_pair do |key, value|
            self.send("#{key}=", value)
          end
        end

        alias_method_chain :initialize, :default_values
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecord::DefaultValue)
