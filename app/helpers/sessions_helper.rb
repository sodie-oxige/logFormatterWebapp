module SessionsHelper
  def autheniticate_user
    if session[:user_id]==nil
      redirect_to("/login")
    end
  end

  def broadcast_notifications
    notions = current_user.notions
    notions.each do |notion|
      ActionCable.server.broadcast("create_logcontents_progress_channel", notion.attributes)
    end
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def current_user?(user)
    user == current_user
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
  end
end
