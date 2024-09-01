class CharactersController < ApplicationController
  def index
    @pc = Pc.joins(:pl).select("pcs.*, pls.name AS pl_name").order(:pl_name)
    @pl = Pl.all.order(:name)
  end

  def new
    @pc = Pc.new
    @pl = Pl.new
  end

  def create_pc
    pc = params.require(:pc)
    @pc = Pl.find(pc[:pl_id]).pcs.new(pc.permit(:name, images: []))
    if @pc.save()
      redirect_to new_character_path
    end
  end

  def create_pl
    @pl = Pl.new(params.require(:pl).permit(:name))
    if @pl.save()
      redirect_to new_character_path
    end
  end

  def edit
    @pc = Pc.find(params[:id])
  end

  def update
    pc = Pc.find(params[:id])
    if pc.update(params.require(:pc).permit(:name, :pl_id, images: []))
      redirect_to edit_character_path(params[:id])
    else
      pp pc.errors.details
    end
  end

  def purge
    pc = Pc.find(params[:id])
    image = pc.images.find(params[:image_id])
    image.purge
    redirect_to(edit_character_path(params[:id]))
  end
end
