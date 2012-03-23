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
#    default_values do
#      {
#        :rating => 'r18',
#        :type => 'comic'
#      }
#    end
#  end
#
#  book = Book.new
#  book.rating # => "r18"
#  book.type # => "comic"
#  book.title # => nil
#
# you can use instance values with lambda:
#
#  class Book < ActiveRecord::Base
#    default_values do
#      lambda do
#        {
#          :type => 'comic',
#          :released_at => Time.now
#        }
#      end
#    end
#  end
#
#  book1 = Book.new
#  # wait 10 sec
#  book2 = Book.new
#  book1.release_at == book2.release_at # => false
#
module ActiveRecord
  module DefaultValue
    extend ActiveSupport::Concern

    module ClassMethods
      def default_values(&block)
        define_method(:initialize_with_default_values) do |*attributes, &inner_block|
          hash_or_lambda = block.call
          hash_or_lambda = hash_or_lambda.call if hash_or_lambda.is_a? Proc
          attributes[0] = hash_or_lambda.merge(attributes.first || {})
          initialize_without_default_values(*attributes, &inner_block)
        end
        alias_method_chain :initialize, :default_values
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecord::DefaultValue)
