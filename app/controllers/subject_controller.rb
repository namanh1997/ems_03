class SubjectController < ApplicationController
  before_action :authenticate_user!
  before_action :supervisor_user, only: %i(new create)

  def index
    @subjects = Subject.sort_by_name.page(params[:page])
                       .per Settings.subjects_per_page
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:info] = t "create_subject_successful"
      redirect_to @subject
    else
      flash.now[:danger] = t "create_subject_failed"
      render :new
    end
  end

  def new
    @subject = Subject.new
  end

  def show
    @subject = Subject.find_by(id: params[:id])
    return if @subject
    flash[:danger] = t "no_subject"
    redirect_to root_path
  end

  private

  def subject_params
    params.require(:subject).permit(:name)
  end
end
