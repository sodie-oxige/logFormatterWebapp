class CreateLogcontentsProgressChannel < ApplicationCable::Channel
  def subscribed
    stream_from "create_logcontents_progress_channel"
  end
end
