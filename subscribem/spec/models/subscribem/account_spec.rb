require 'spec_helper'

describe Subscribem::Account do
  def schema_exists?(account)
    query = %Q{SELECT nspname FROM pg_namespace 
               WHERE nspname='#{account.subdomain}'}
    result = ActiveRecord::Base.connection.select_value(query)
    result.present?
  end

  it "creates a schema" do
    account = Subscribem::Account.create!(:name => "First Account", :subdomain => "test")
    account.create_schema
    assert schema_exists?(account), "Schema #{account.subdomain} does not exist"
  end

  it "can be created with an owner" do
    params = {
      :name => "Test Account",
      :subdomain => "test",
      :owner_attributes => {
        :email => "user@example.com",
        :password => "password",
        :password_confirmation => "password"
      }
    }

    account = Subscribem::Account.create_with_owner(params)
    account.users.first.should == account.owner
  end

  it "cannot create an account without a subdomain" do
    account = Subscribem::Account.create_with_owner
    account.should_not be_valid
    account.users.should be_empty
  end
end
