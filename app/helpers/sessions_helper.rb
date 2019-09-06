module SessionsHelper
  def sign_in user
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def signed_in?
    current_user.present?
  end

  def sign_out
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user? user
    user == current_user
  end

  def user_role role
    User.roles.key User.roles[role]
  end

  def redirect_back_or default
    redirect_to session[:forwarding_url] || default
    session.delete :forwarding_url
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  private

  def current_supervisor?
    current_user.supervisor?
  end
end
