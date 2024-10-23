class UsersController < ApplicationController
  skip_before_action :autheniticate_user, only: [ :new, :create ]
  def index
    @user = current_user
  end

  def new
    if User.count >= 1
      autheniticate_user
    end
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:name, :userid, :password, :password_confirmation)
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to(logs_path)
    else
      pp @user.errors.details
      redirect_to(new_users_path)
    end
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
