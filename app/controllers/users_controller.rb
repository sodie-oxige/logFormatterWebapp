class UsersController < ApplicationController
  def index
    @user = current_user
  end

  def edit
  end

  def update
    setting_param = params.require(:user).permit(:appearanceMode, :password)
    user = current_user
    pp setting_param
    if user.update(setting_param)
      redirect_to "/user"
    else
      pp user.errors.details
    end
  end
end
