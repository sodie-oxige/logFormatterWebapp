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
    log_params = params.require(:log).slice(:name, :date, :hidden, :pc_ids).permit(:name, :date, :hidden, pc_ids: [])
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
    log_params = params.require(:log).slice(:name, :date, :gm, :pc_ids).permit(:name, :date, :gm, pc_ids: [])
    log_params[:gm] = User.find(params.require(:log)[:gm])
    log_params[:pc_ids].reject!(&:blank?)
    @log = Log.find(params[:id])
    @pcs = @log.appear_pcs
    if @log.update(log_params)
      redirect_to(logs_path)
    else
      pp @log.errors.details
      redirect_to(edit_log_path(params[:id]))
    end
  end

  def destroy
  end

  def show
    @id = params[:id]
    @log = Log.find(@id)
    @page = (params[:page] || @log[:bookmark] || 1).to_i
    @log_content = @log.log_contents.find_by(index: @page)
    if !@log_content
      redirect_to(log_preparing_path(@id))
    end
    @log.update(bookmark: @page)
  end

  def log_content
    @id = params[:id]
    @page = params[:page].to_i
    log = Log.find(@id)
    @log_content = log.log_contents.find_by(index: @page)
    char = nil
    author = @log_content[:author].gsub(/[[:space:]]/, "")
    char = Character.find_by("REGEXP_REPLACE(name, '\s+', '') = ? and ((is_pc = true and pl_id <> ?) or (is_pc = false and pl_id = ?))", author, log[:gm_id], log[:gm_id])
    char ||= Nickname.find_by("REGEXP_REPLACE(name, '\s+', '') = ?", author)&.character
    if @log_content.present?
      log.update(bookmark: @page)
      render json: {
        author: @log_content[:author],
        color: @log_content[:color],
        tab: @log_content[:tab],
        content: @log_content[:content],
        images: char ? char.images&.map { |image| url_for(image) } : "",
        char: char
      }
    else
      redirect_to(log_preparing_path(@id))
    end
  end

  $backlog_size = 40

  def backlog_content
    @id = params[:id]
    backlog_page = params[:page].to_i
    @backlogs = Log.find(@id).log_contents.where(index: backlog_page-($backlog_size-1)/2 .. backlog_page+$backlog_size/2)
    if @backlogs.length != 0
      render partial: "backlog_content"
    else
      render plain: ""
    end
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
