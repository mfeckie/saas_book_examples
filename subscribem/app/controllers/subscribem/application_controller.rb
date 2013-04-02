module Subscribem
  class ApplicationController < ::ApplicationController 
    def force_authentication!(user)
      env['warden'].set_user(user.id, :scope => :user)
    end
  end
end
