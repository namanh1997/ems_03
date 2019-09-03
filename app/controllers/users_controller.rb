class UsersController < ApplicationController
  before_action :signed_in_user, except: %i(new show create)
  before_action :load_user, except: %i(new index create)
  before_action :correct_user, only: %i(edit update)
  before_action :supervisor_user, only: :destroy

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

  def new
    @user = User.new
  end

  def edit; end

  def show
    @trainee_exams = TraineeExam.get_by_user(@user.id).page(params[:page])
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

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "no_user"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def correct_user
    redirect_to root_url unless current_user?(@user) || current_supervisor?
  end

  def supervisor_user
    redirect_to root_url unless current_supervisor?
  end
end
