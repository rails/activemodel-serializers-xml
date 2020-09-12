$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'active_model/serializers'

require 'active_support/testing/autorun'

TEST_ROOT       = File.expand_path(File.dirname(__FILE__))
FIXTURES_ROOT   = TEST_ROOT + "/fixtures"
require 'active_support/core_ext/string/access'
require 'stringio'

require 'active_record'
require 'active_support/dependencies'
require 'active_support/logger'
require 'active_support/core_ext/string/strip'

Thread.abort_on_exception = true

# Show backtraces for deprecated behavior for quicker cleanup.
ActiveSupport::Deprecation.debug = true

# Disable available locale checks to avoid warnings running the test suite.
I18n.enforce_available_locales = false

# Connect to the database
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

class ActiveRecord::TestCase < ActiveSupport::TestCase
  include ActiveRecord::TestFixtures

  self.fixture_path = FIXTURES_ROOT
  self.use_instantiated_fixtures  = false

  def create_fixtures(*fixture_set_names, &block)
    ActiveRecord::FixtureSet.create_fixtures(ActiveSupport::TestCase.fixture_path, fixture_set_names, fixture_class_names, &block)
  end

  def with_env_tz(new_tz = 'US/Eastern')
    old_tz, ENV['TZ'] = ENV['TZ'], new_tz
    yield
  ensure
    old_tz ? ENV['TZ'] = old_tz : ENV.delete('TZ')
  end

  def with_timezone_config(cfg)
    verify_default_timezone_config

    old_default_zone = ActiveRecord::Base.default_timezone
    old_awareness = ActiveRecord::Base.time_zone_aware_attributes
    old_zone = Time.zone

    if cfg.has_key?(:default)
      ActiveRecord::Base.default_timezone = cfg[:default]
    end
    if cfg.has_key?(:aware_attributes)
      ActiveRecord::Base.time_zone_aware_attributes = cfg[:aware_attributes]
    end
    if cfg.has_key?(:zone)
      Time.zone = cfg[:zone]
    end
    yield
  ensure
    ActiveRecord::Base.default_timezone = old_default_zone
    ActiveRecord::Base.time_zone_aware_attributes = old_awareness
    Time.zone = old_zone
  end

  # This method makes sure that tests don't leak global state related to time zones.
  EXPECTED_ZONE = nil
  EXPECTED_DEFAULT_TIMEZONE = :utc
  EXPECTED_TIME_ZONE_AWARE_ATTRIBUTES = false
  def verify_default_timezone_config
    if Time.zone != EXPECTED_ZONE
      $stderr.puts <<-MSG
  \n#{self}
      Global state `Time.zone` was leaked.
        Expected: #{EXPECTED_ZONE}
        Got: #{Time.zone}
      MSG
    end
    if ActiveRecord::Base.default_timezone != EXPECTED_DEFAULT_TIMEZONE
      $stderr.puts <<-MSG
  \n#{self}
      Global state `ActiveRecord::Base.default_timezone` was leaked.
        Expected: #{EXPECTED_DEFAULT_TIMEZONE}
        Got: #{ActiveRecord::Base.default_timezone}
      MSG
    end
    if ActiveRecord::Base.time_zone_aware_attributes != EXPECTED_TIME_ZONE_AWARE_ATTRIBUTES
      $stderr.puts <<-MSG
  \n#{self}
      Global state `ActiveRecord::Base.time_zone_aware_attributes` was leaked.
        Expected: #{EXPECTED_TIME_ZONE_AWARE_ATTRIBUTES}
        Got: #{ActiveRecord::Base.time_zone_aware_attributes}
      MSG
    end
  end
end

ActiveRecord::Schema.verbose = false
ActiveRecord::Schema.define do
  create_table :addresses do |t|
    t.string :city
  end

  create_table :ar_contacts do |t|
    t.string :name
    t.integer :age
    t.binary :avatar
    t.boolean :awesome
    t.string :preferences
    t.integer :alternative_id
    t.string :address
    t.timestamps
  end

  create_table :contact_stis do |t|
    t.string :type
    t.string :name
    t.integer :age
    t.binary :avatar
    t.boolean :awesome
    t.string :preferences
    t.integer :alternative_id
    t.string :address
    t.timestamps
  end

  create_table :topics do |t|
    t.string :title
    t.string :author_name
    t.string :author_email_address
    t.datetime :written_on
    t.date :last_read
    t.datetime :bonus_time
    t.text :content
    t.boolean :approved
    t.integer :replies_count
    t.integer :parent_id
    t.string :type
  end

  create_table :companies do |t|
    t.integer :firm_id
    t.integer :client_of
    t.string :name
    t.string :firm_name
    t.string :type
  end

  create_table :accounts do |t|
    t.integer :firm_id
    t.integer :credit_limit
    t.string :firm_name
  end

  create_table :authors do |t|
    t.string :name
    t.integer :author_address_id
    t.integer :author_address_extra_id
    t.string :organization_id
    t.string :owned_essay_id
  end

  create_table :toys do |t|
    t.string :name
    t.timestamps
  end

  create_table :posts do |t|
    t.string :title
    t.string :category
    t.integer :author_id
    t.text :body
    t.integer :comments_count
    t.integer :tags_count
    t.string :type
  end

  create_table :comments do |t|
    t.string :title
    t.references :post
  end

  create_table :projects do |t|
    t.string :name
  end
end
