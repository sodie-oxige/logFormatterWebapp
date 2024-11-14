module SessionsHelper
  def autheniticate_user
    if session[:user_id]==nil
      redirect_to("/login")
    end
  end

  def broadcast_notifications
    keys = $redis.keys("notifications:user:#{current_user.id}:job:*")
    keys.each do |key|
      message = $redis.hgetall(key)
      ActionCable.server.broadcast("create_logcontents_progress_channel", message)
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
