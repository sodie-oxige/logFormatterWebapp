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
    @log = Log.new
  end
  def create
    gm = Pl.find(params.require(:log)[:gm])
    log_params = params.require(:log).slice(:name, :date, :pc_ids).permit(:name, :date, pc_ids: [])
    log_params[:pc_ids].reject!(&:blank?)
    @log = gm.logs.new(log_params)
    if @log.save
      File.rename("temp.html", "public/logfile/#{@log.id}.html")
      redirect_to(logs_path)
    else
      pp @log.errors.details
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
      redirect_to(log_preparing_path(@id))
    else
      @file = File.open("#{Rails.public_path}/logjson/#{@id}.json").read
      logjson = JSON.load(@file)
      now_ver = ($log_format_version.split(".")+[ 0, 0 ])[0..2]
      log_ver = logjson["version"].split(".")
      if now_ver[0] > log_ver[0] || (now_ver[0] = log_ver[0] && now_ver[1] > log_ver[1])
        redirect_to(log_preparing_path(@id))
      end
    end
  end

  def preparing # get
    @id = params[:id]
    @ver = $log_format_version
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
