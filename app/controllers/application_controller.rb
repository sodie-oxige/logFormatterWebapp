class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  include SessionsHelper
  before_action :autheniticate_user

  def page404
    render template: "errors/404", status: 404
  end
end
