module Subscribem
  class Account::DashboardController < Subscribem::ApplicationController
    before_filter :authenticate_user!
  end
end
