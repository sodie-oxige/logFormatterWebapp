class CreateLogcontentsProgressChannel < ApplicationCable::Channel
  def subscribed
    stream_from "create_logcontents_progress_channel"
    Rails.logger.debug "[ActionCable] Subscribed to CreateLogcontentsProgressChannel"
  end

  def unsubscribed
    Rails.logger.debug "[ActionCable] Unsubscribed from CreateLogcontentsProgressChannel"
  end
end
