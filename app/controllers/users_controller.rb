class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user, except: %i(new index create)
  before_action :supervisor_user, only: :destroy

  def index
    @users = User.sort_by_name.page(params[:page]).per Settings.users_per_page
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:info] = t "create_user_successful"
    else
      flash.now[:danger] = t "create_user_failed"
      render :new
    end
  end

  def new
    @user = User.new
  end

  def show
    @trainee_exams = @user.trainee_exams.page(params[:page])
                          .per Settings.trainee_exams_per_page
  end

  def update
    if @user.update user_params
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "user deleted"
    else
      flash.now[:danger] = t "delete_user_failed"
    end
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "no_user"
    redirect_to root_path
  end
end
