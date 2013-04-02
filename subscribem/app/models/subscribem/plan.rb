module Subscribem
  class Plan < ActiveRecord::Base
    attr_accessible :braintree_id, :description, :name, :price
  end
end
