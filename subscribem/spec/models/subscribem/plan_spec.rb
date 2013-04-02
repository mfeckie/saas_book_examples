require 'spec_helper'

describe Subscribem::Plan do
  context "creating a plan within Subscribem" do
    it "creates a plan on Stripe" do
      Stripe::Plan.should_receive(:create).with({
        :id => "basic",
        :name => "Basic",
        :amount => 0,
        :interval => "month",
        :currency => "usd"
      })

      Subscribem::Plan.create!(:name => "Basic", :amount => 0)
    end
  end

end
