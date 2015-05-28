require 'active_support'
require 'active_support/lazy_load_hooks'
require 'active_record'
require 'active_model'
require "active_model/deprecated_serializers/version"

ActiveSupport.on_load(:active_model) do
  require "active_model/deprecated_serializers/xml"
end

ActiveSupport.on_load(:active_record) do
  require "active_record/serializers/xml_serializer"
end

module ActiveModel
  module DeprecatedSerializers
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :Xml
    end
  end

  def self.eager_load!
    super
    ActiveModel::DeprecatedSerializers.eager_load!
  end
end
