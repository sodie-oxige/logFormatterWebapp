class LogsController < ApplicationController
  $log_format_version = "0.9.0"

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
    @id = params[:id]
    if !File.exist?("#{Rails.public_path}/logjson/#{@id}.json")
      # var = (@log_format_version.split(".")+[ 0, 0 ])[0..2]
      redirect_to(log_preparing_path(@id))
    end
  end

  def preparing # get
    @id = params[:id]
    @ver = $log_format_version
    puts @ver
  end

  def make_json # post
    @id = params[:id]
    if File.exist?("#{Rails.public_path}/logfile/#{@id}.html")
      data=params[:json]
      File.write("public/logjson/#{@id}.json", data, encoding: Encoding::UTF_8)
      redirect_to(log_path(@id))
    end
  end
end
