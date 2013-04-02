ApplicationController.class_eval do
  def current_user
    if user_signed_in?
      Subscribem::User.find(env['warden'].user(:scope => :user))
    end
  end
  helper_method :current_user

  def current_account
    if user_signed_in?
      Subscribem::Account.find(env['warden'].user(:scope => :account))
    end
  end
  helper_method :current_account

  def user_signed_in?
    env['warden'].authenticated?(:user)
  end
  helper_method :user_signed_in?

  def authenticate_user!
    unless user_signed_in?
      flash[:notice] = "Please sign in."
      redirect_to '/sign_in'
    end
  end
end
