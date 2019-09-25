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
    return if current_user.supervisor?
    flash[:error] = t "must_be_supervisor"
    redirect_to root_url
  end
end
