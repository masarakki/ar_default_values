module DefaultValues
  class Railtie < ::Rails::Railtie
    initializer 'default_values.initialize' do
      ActiveSupport.on_load :active_record do
        include DefaultValues::DSL
      end
    end
  end
end
