module ApplicationCable
  class Connection < ActionCable::Connection::Base
    def connect
      Rails.logger.info "WebSocket connection established"
    end

    def disconnect
      Rails.logger.info "WebSocket connection closed"
    end
  end
end
