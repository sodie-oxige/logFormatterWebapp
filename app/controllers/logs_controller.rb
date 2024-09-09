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
    @log = Log.new
  end
  def create
    gm = User.find(params.require(:log)[:gm])
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
    log_params = params.require(:log).slice(:name, :date, :pc_ids).permit(:name, :date, pc_ids: [])
    log_params[:pc_ids].reject!(&:blank?)
    @log = Log.find(params[:id])
    @pcs = @log.appear_pcs
    if @log.update(log_params)
      redirect_to(logs_path)
    else
      redirect_to(new_log_path)
    end
  end

  def destroy
  end

  def show
    @id = params[:id]
    @page = params[:page] || Log.find(@id)[:bookmark] || 1
    @log_content = Log.find(@id).log_contents.find_by(index: @page)
    if !@log_content
      redirect_to(log_preparing_path(@id))
    end
    Log.find(@id).update(bookmark: @page)
  end

  def preparing # get
    @id = params[:id]
  end

  def make_log_content # post
    @id = params[:id]
    if !Log.find(@id).log_contents.exists?(index: params[:index])
      Log.find(@id).log_contents.create(params.slice(:index, :color, :tab, :author, :content).permit(:index, :color, :tab, :author, :content))
    else
      Log.find(@id).log_contents.find_by(index: params[:index]).update(params.slice(:color, :tab, :author, :content).permit(:color, :tab, :author, :content))
    end
    head(:created)
  end
end
