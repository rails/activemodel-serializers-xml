require 'minitest_helper'

class TestActiveModel::DeprecatedSerializers < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ActiveModel::DeprecatedSerializers::VERSION
  end

  def test_it_does_something_useful
    assert false
  end
end
