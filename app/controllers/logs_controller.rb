class LogsController < ApplicationController
  def index
    @logs = Log.all
  end

  def create
  end

  def destroy
  end

  def show
  end
end
