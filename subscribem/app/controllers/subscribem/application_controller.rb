module Subscribem
  class ApplicationController < ::ApplicationController 
    def force_authentication!(user)
      env['warden'].set_user(user.id, :scope => :user)
    end

    def owner?
      current_account.owner?(current_user)
    end
    helper_method :owner?

    def authorize_owner
      unless owner?
        flash[:error] = "You are not allowed to do that."
        redirect_to root_path
      end
    end
  end
end
