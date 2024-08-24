class LogsController < ApplicationController
  def index
    @logs = Log.all.order(:date)
  end

  def pre_new
    text = params[:file].read
    text.force_encoding(Encoding::UTF_8)
    File.write(Rails.root.join("temp.html"), text, encoding: Encoding::UTF_8)
    redirect_to(new_log_path)
  end
  def new
    if !File.read("temp.html") then redirect_to(logs_path) end
  end

  def create
  end

  def destroy
  end

  def show
  end
end
