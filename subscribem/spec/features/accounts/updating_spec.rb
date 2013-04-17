require 'spec_helper'
require 'subscribem/testing_support/authentication_helpers'
require 'subscribem/testing_support/factories/account_factory'

feature "Accounts" do
  include Subscribem::TestingSupport::AuthenticationHelpers
  let(:account) { FactoryGirl.create(:account_with_schema) }
  let(:root_url) { "http://#{account.subdomain}.example.com/" }

  context "as the account owner" do
    before do
      sign_in_as(:user => account.owner, :account => account)
    end

    scenario "updating an account" do
      visit root_url
      click_link 'Edit Account'
      fill_in "Name", :with => "A new name"
      click_button "Update Account"
      page.should have_content("Account updated successfully.")
    end

    scenario "updating an account with invalid attributes fails" do 
      visit root_url
      click_link "Edit Account"
      fill_in "Name", :with => ''
      click_button "Update Account"
      page.should have_content("Account could not be updated.")
    end

    context "with plans" do
      let!(:starter_plan) do
        Subscribem::Plan.create!(
          :name  => 'Starter',
          :price => 9.95
        )
      end

      let!(:extreme_plan) do
        Subscribem::Plan.create!(
          :name  => 'Extreme',
          :price => 19.95
        )
      end

      before do
        account.update_column(:plan_id, starter_plan.id)
      end

      scenario "updating an account's plan" do
        query_string = Rack::Utils.build_query(
          :plan_id => extreme_plan.id,
          :http_status => 200,
          :id => "a_fake_id",
          :kind => "create_transaction",
          :hash => "872122d7872e6fdc8ae7fc0bd395f8eb96f33345"
        )
        Braintree::TransparentRedirect.should_receive(:confirm).with(query_string)

        visit root_url
        click_link 'Edit Account'
        page.find("#account_plan_info").should_not be_visible
        select 'Extreme', :from => 'Plan'
        click_button "Update Account"
        page.should have_content("Account updated successfully.")
        plan_url = subscribem.plan_account_url(
          :plan_id => extreme_plan.id,
          :subdomain => account.subdomain)
        page.current_url.should == plan_url
        page.should have_content("You are changing to the 'Extreme' plan")
        page.should have_content("This plan costs $19.95 per month.")
        fill_in "First name", :with => "Test"
        fill_in "Last name", :with => "User"
        fill_in "Credit card number", :with => "4111111111111111"
        future_date = "#{Time.now.month + 1}/#{Time.now.year + 1}"
        fill_in "Expiration date", :with => future_date
        fill_in "CVV", :with => "123"
        click_button "Change plan"
        page.should have_content("You have switched to the 'Extreme' plan.")
        page.current_url.should == root_url
      end
    end
  end

  context "as a user" do
    before do
      user = FactoryGirl.create(:user)
      sign_in_as(:user => user, :account => account)
    end

    scenario "cannot edit an account's information" do
      visit subscribem.account_url(:subdomain => account.subdomain)
      page.should have_content("You are not allowed to do that.")
    end
  end
end
