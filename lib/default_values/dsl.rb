module DefaultValues
  module DSL
    extend ActiveSupport::Concern

    module ClassMethods
      def default_values(defaults = {}, &block)
        define_method(:initialize_with_default_values) do |*attributes, &inner_block|
          values = defaults
          values = values.merge(block.call) if block_given?
          values = Hash[values.each_pair.map { |key, value| [key, value.is_a?(Proc) ? value.call : value] }]

          initialize_without_default_values(*attributes, &inner_block)

          values.each_pair do |key, value|
            write_attribute(key, value) unless attribute_present?(key)
          end
        end
        alias_method_chain :initialize, :default_values
      end
    end
  end
end
