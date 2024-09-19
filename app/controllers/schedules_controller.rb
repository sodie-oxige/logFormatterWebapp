class SchedulesController < ApplicationController
  def index
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
    @schedules = Game.joins(:schedules).select("games.*, schedules.*").where("date between ? and ?", start_date, end_date).order(Arel.sql("CASE WHEN games.name = 'リアル' THEN 0 ELSE 1 END"))
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
    @year = params.fetch(:year, Time.zone.today.year).to_i
    @month = params.fetch(:month, Time.zone.today.month).to_i
    game = params[:game]
    responses = params.select { |k, v| k.start_with?("response") }.values
    @game = Game.create(name: game)
    i=1
    responses.each do |res|
      @game.schedules.create(date: params[:yearMonth]+"-"+i.to_s, response: res)
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
    @game = Game.find(params[:id])
  end

  def update
    @year = params.fetch(:year, Time.zone.today.year).to_i
    @month = params.fetch(:month, Time.zone.today.month).to_i
    game = params[:game]
    responses = game.select { |k, v| k.start_with?("response") }.values
    @game = Game.find(params[:id])
    if @game.update(params.require(:game).slice(:name).permit(:name))
      i=1
      responses.each do |res|
        @game.schedules.find { |s| s.date.strftime("%Y-%m-%d") == game[:yearMonth]+"-"+("%02d" % i) }.update(params.require(:game).merge(response: res).slice(:response).permit(:response))
        i+=1
      end
      redirect_to(schedules_path(year: @year, month: @month))
    end
  end
end
