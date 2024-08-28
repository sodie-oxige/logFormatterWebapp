class LogsController < ApplicationController
  def index
    @logs = Log.all.order(:date)
  end

  def pre_new
    text = params[:file].read
    text.force_encoding(Encoding::UTF_8)
    File.write("temp.html", text, encoding: Encoding::UTF_8)
    redirect_to(new_log_path(filename: params[:file].original_filename))
  end
  def new
    if !File.exist?("temp.html") then redirect_to(logs_path) end
    @filename = params[:filename]
    @log = Log.new()
  end

  def create
    @log = Log.new(params.require(:log).permit(:name, :date, :gm))
    pcs = params.require(:log)[:pcs]
    if @log.save
      pcs.reject(&:blank?).each do |pc|
        @log.appear_pcs.create(pc: pc)
      end
      File.rename("temp.html", "public/logfile/#{@log.id}.html")
      redirect_to(logs_path)
    else
      redirect_to(new_log_path)
    end
  end

  def edit
    @log = Log.find(params[:id])
  end

  def update
    @log = Log.find(params[:id])
    @pcs = @log.appear_pcs
    if @log.update(params.require(:log).permit(:name, :date, :gm))
      @pcs.each do |pc|
        pc.update(pc: pc)
      end
      redirect_to(logs_path)
    else
      redirect_to(new_log_path)
    end
  end

  def destroy
  end

  def show
    json_create(params[:id])
  end

  def preparing
    @id = params[:id]
  end

  def json_create(id)
    if File.exist?("#{Rails.public_path}/logfile/#{id}.html")
      File.open("#{Rails.public_path}/logfile/#{id}.html") do |j|
      end
    end
    data={}
    File.write("public/logjson/#{id}.json", data, encoding: Encoding::UTF_8)
  end
end
