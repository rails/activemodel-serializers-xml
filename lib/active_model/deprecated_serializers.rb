require 'active_support/lazy_load_hooks'
require "active_model/deprecated_serializers/version"

ActiveSupport.on_load(:active_model) do
  require "active_model/deprecated_serializers/xml"
end
