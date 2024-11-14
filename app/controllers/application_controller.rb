class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  include ApplicationHelper
  include SessionsHelper
  before_action :autheniticate_user
  after_action :broadcast_notifications

  def page404
    render template: "errors/404", status: 404
  end
end
