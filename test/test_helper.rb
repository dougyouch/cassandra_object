# lib = File.expand_path("#{File.dirname(__FILE__)}/../lib")
# $:.unshift(lib) unless $:.include?('lib') || $:.include?(lib)
# require File.expand_path('../../lib/cassandra_object', __FILE__)
require 'cassandra/0.8'
require 'cassandra_object'
require 'rails/test_help'

class Issue < CassandraObject::Base
  key :uuid
  attribute :description, :type => :string
  attribute :worth, :type => :decimal, :precision => 100
end

module CassandraObject
  class TestCase < ActiveSupport::TestCase
    TEST_KEYSPACE = 'place_directory_development'

    setup do
      CassandraObject::Base.establish_connection(
        :keyspace => TEST_KEYSPACE,
        # servers: '192.168.0.100:9160'
        :servers => '127.0.0.1:9160'
      )
    end

    teardown do
      Issue.delete_all
    end

    def connection
      CassandraObject::Base.connection
    end
  end
end
