class Thing < ActiveRecord::Base
  attr_accessible :account, :name
  scoped_to_account
end
