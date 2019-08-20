class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".no_user"
    redirect_to root_path
  end

  def index
    @users = User.sort_by_name.page(params[:page]).per Settings.users_per_page
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:info] = t "create_user_successful"
      redirect_to @user
    else
      flash.now[:danger] = t "create_user_failed"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :role
  end
end
