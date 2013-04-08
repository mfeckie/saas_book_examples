require_dependency "subscribem/application_controller"

module Subscribem
  class Account::AccountsController < ApplicationController
    before_filter :authorize_owner, :only => [:edit, :update]

    def update
      if current_account.update_attributes(params[:account])
        flash[:success] = "Account updated successfully."
        redirect_to root_path
      else
        flash[:error] = "Account could not be updated."
        render :edit
      end
    end
  end
end

