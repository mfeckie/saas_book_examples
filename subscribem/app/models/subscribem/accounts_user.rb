module Subscribem
  class AccountsUser < ActiveRecord::Base
    belongs_to :account, :class_name => "Subscribem::Account"
    belongs_to :user, :class_name => "Subscribem::User"
  end
end
