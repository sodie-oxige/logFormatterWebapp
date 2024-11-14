class SessionsController < ApplicationController
  skip_before_action :autheniticate_user
  skip_after_action :broadcast_notifications
  def new
  end

  def create
    user = User.find_by(userid: params[:session][:userid])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to root_url
    else
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
