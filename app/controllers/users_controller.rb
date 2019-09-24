class UsersController < ApplicationController
  before_action :load_user, only: :show

  def index
    @users = User.sort_by_name.page(params[:page]).per Settings.users_per_page
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "no_user"
    redirect_to root_path
  end
end
