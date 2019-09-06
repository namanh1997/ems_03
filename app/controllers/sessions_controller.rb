class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:danger] = t "invalid"
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
