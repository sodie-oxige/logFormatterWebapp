class SchedulesController < ApplicationController
  def index
    @year = params.fetch(:year, Time.zone.today.year).to_i
    @month = params.fetch(:month, Time.zone.today.month).to_i
    pp @year
    pp @month
    start_date = Date.new(@year, @month, 1)
    end_date = start_date.end_of_month
    @calendars = []
    date = start_date
    until date > end_date do
      @calendars.push(date)
      date = date.next_day
    end
    @schedules = Session.joins(:schedules).select("sessions.*, schedules.*").where("date between ? and ?", start_date, end_date)
  end

  def new
    @year = params.fetch(:year, Time.zone.today.year).to_i
    @month = params.fetch(:month, Time.zone.today.month).to_i
    start_date = Date.new(@year, @month, 1)
    end_date = start_date.end_of_month
    @calendars = []
    date = start_date
    until date > end_date do
      @calendars.push(date)
      date = date.next_day
    end
  end

  def create
    pp params
    @year = params.fetch(:year, Time.zone.today.year).to_i
    @month = params.fetch(:month, Time.zone.today.month).to_i
    session = params[:session]
    responses = params.select { |k, v| k.start_with?("response") }.values
    @session = Session.create(name: session)
    i=1
    responses.each do |res|
      @session.schedules.create(date: params[:yearMonth]+"-"+i.to_s, response: res)
      i+=1
    end
      redirect_to(schedules_path(year: @year, month: @month))
  end

  def edit
    @year = params.fetch(:year, Time.zone.today.year).to_i
    @month = params.fetch(:month, Time.zone.today.month).to_i
    start_date = Date.new(@year, @month, 1)
    end_date = start_date.end_of_month
    @calendars = []
    date = start_date
    until date > end_date do
      @calendars.push(date)
      date = date.next_day
    end
    @session = Session.find(params[:id])
  end

  def update
    @year = params.fetch(:year, Time.zone.today.year).to_i
    @month = params.fetch(:month, Time.zone.today.month).to_i
    session = params[:session]
    responses = session.select { |k, v| k.start_with?("response") }.values
    @session = Session.find(params[:id])
    if @session.update(params.require(:session).slice(:name).permit(:name))
      i=1
      responses.each do |res|
        target = session[:yearMonth]+"-"+("%02d" % i)
        @session.schedules.find { |s| s.date.strftime("%Y-%m-%d") == target }.update(params.require(:session).merge(response: res).slice(:response).permit(:response))
        i+=1
      end
      redirect_to(schedules_path(year: @year, month: @month))
    end
  end
end
