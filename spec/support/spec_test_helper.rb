module SpecTestHelper
  def sign_in user
    request.session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def sign_out
    session.delete :user_id
    @current_user = nil
  end

  def redirect_back_or default
    redirect_to session[:forwarding_url] || default
    request.session.delete :forwarding_url
  end

  def store_location
    request.session[:forwarding_url] = request.original_url if request.get?
  end
end
