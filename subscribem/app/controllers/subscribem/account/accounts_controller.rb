require_dependency "subscribem/application_controller"

module Subscribem
  class Account::AccountsController < ApplicationController
    before_filter :authorize_owner, :only => [:edit, :update]

    def update
      if current_account.update_attributes(params[:account])
        flash[:success] = "Account updated successfully."
        if current_account.previous_changes.include?("plan_id")
          plan = current_account.plan
          redirect_to plan_account_url(:plan_id => plan) and return
        end
        redirect_to root_path
      else
        flash[:error] = "Account could not be updated."
        render :edit
      end
    end

    def confirm_plan
      plan = Subscribem::Plan.find(params[:plan_id])
      result = Braintree::TransparentRedirect.confirm(request.query_string)
      flash[:success] = "You have switched to the '#{plan.name}' plan."
      redirect_to root_path
    end

    def plan
      @plan = Subscribem::Plan.find(params[:plan_id])
    end
  end
end

