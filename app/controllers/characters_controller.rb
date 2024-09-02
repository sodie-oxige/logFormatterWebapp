class CharactersController < ApplicationController
  def index
    @pc = Character.joins(:pl).where(is_pc: true).select("characters.*, pls.name AS pl_name").order(:pl_name)
    @npc = Character.joins(:pl).where(is_pc: false).select("characters.*, pls.name AS pl_name").order(:pl_name)
    @pl = Pl.all.order(:name)
  end

  def new
    @pc = Character.new
    @pl = Pl.new
  end

  def create
    pc = params.require(:character)
    @pc = Pl.find(pc[:pl_id]).characters.new(pc.permit(:name, :is_pc, images: []))
    pp @pc
    if @pc.save()
      redirect_to new_character_path
    else
      pp @pc.errors.details
    end
  end

  def create_pl
    @pl = Pl.new(params.require(:pl).permit(:name))
    if @pl.save()
      redirect_to new_character_path
    end
  end

  def edit
    @character = Character.find(params[:id])
  end

  def update
    character = Character.find(params[:id])
    if character.update(params.require(:pc).permit(:name, :pl_id, images: []))
      redirect_to edit_character_path(params[:id])
    else
      pp character.errors.details
    end
  end

  def purge
    character = Character.find(params[:id])
    image = character.images.find(params[:image_id])
    image.purge
    redirect_to(edit_character_path(params[:id]))
  end
end
