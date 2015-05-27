require 'minitest_helper'

module TestActiveModel
  class DeprecatedSerializers < Minitest::Test
    def test_that_it_has_a_version_number
      refute_nil ::ActiveModel::DeprecatedSerializers::VERSION
    end
  end
end
