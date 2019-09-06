class ApplicationController < ActionController::Base
  before_action :set_locale
  protect_from_forgery with: :exception

  include SessionsHelper

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def supervisor_user
    redirect_to root_url unless current_user.supervisor?
  end

  def signed_in_user
    return if signed_in?
    store_location
    flash[:danger] = t ".pleaselogin"
    redirect_to signin_path
  end
end
