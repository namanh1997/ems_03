class UsersController < ApplicationController
  def new; end

  def show
    @user = User.find_by(params[:id])
    return if @user
    flash[:danger] = I18n.t ".no_user"
    redirect_to root_path
  end
end
