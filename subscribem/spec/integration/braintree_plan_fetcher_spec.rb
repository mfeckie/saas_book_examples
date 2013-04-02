require 'spec_helper'

describe BraintreePlanFetcher do
  let(:faux_plan) do
    double('Plan', 
             :id    => "faux1",
             :name  => "Bronze",
             :price => "9.95")
  end

  it "fetches and stores plans" do
    Braintree::Plan.should_receive(:all).and_return([faux_plan])
    Subscribem::Plan.should_receive(:create).with({
      :braintree_id => "faux1",
      :name         => "Bronze",
      :price        => "9.95"
    })

    BraintreePlanFetcher.store_locally
  end

  it "checks and updates plans" do
    Braintree::Plan.should_receive(:all).and_return([faux_plan])
    Subscribem::Plan.should_receive(:find_by_braintree_id).
                     with('faux1').
                     and_return(plan = stub)
    plan.should_receive(:update_attributes).with({
      :name => "Bronze",
      :price => "9.95"
    })

    BraintreePlanFetcher.store_locally
  end

end
