class CallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :authenticate_user!
  def all
    user = User.from_omniauth(request.env['omniauth.auth'])
    if user.persisted?
      flash[:notice] = 'you are successfully logged in!!'
      sign_in_and_redirect(user)
    else
      session['devise.user_attributes'] = user.attributes
      flash[:error] = 'This email has already been taken.'
      redirect_to new_user_session_path
    end
  end

  def failure
    super
  end

  alias_method :facebook, :all
  alias_method :google_oauth2, :all
end
