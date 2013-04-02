require 'database_cleaner'

module Subscribem
  module TestingSupport
    module DatabaseCleaning
      def self.included(config)
        config.before(:suite) do
          DatabaseCleaner.strategy = :truncation
          DatabaseCleaner.clean_with(:truncation)
        end

        config.before(:each) do
          DatabaseCleaner.start
        end

        config.after(:each) do
          Apartment::Database.reset
          DatabaseCleaner.clean
          connection = ActiveRecord::Base.connection.raw_connection
          schemas = connection.query(%Q{
            SELECT 'drop schema ' || nspname || ' cascade;'
            from pg_namespace where nspname != 'public' AND
            nspowner !=
            (select oid from pg_roles where rolname = 'postgres');
          })
          schemas.each do |query|
            connection.query(query.values.first)
          end
        end
      end
    end
  end
end
