class CharactersController < ApplicationController
  def index
    @pc = Character.joins(:pl).where(is_pc: true).select("characters.*, users.name AS pl_name").order(:pl_name)
    @npc = Character.joins(:pl).where(is_pc: false).select("characters.*, users.name AS pl_name").order(:pl_name)
    @pl = User.filtered_all.order(:name)
  end

  def new
    @pc = Character.new
    @pl = User.new
  end

  def create
    pc = params.require(:character)
    @pc = User.find(pc[:pl_id]).characters.new(pc.permit(:name, :is_pc, images: []))
    pp @pc
    if @pc.save()
      redirect_to new_character_path
    else
      pp @pc.errors.details
    end
  end

  def create_pl
    @pl = User.new(params.require(:user).permit(:name).merge(userid: "default", password: "default"))
    if @pl.save()
      redirect_to new_character_path
    else
      pp @pl.errors.details
    end
  end

  def edit
    @character = Character.find(params[:id])
  end

  def update
    character = Character.find(params[:id])
    character_params = params.require(:character).permit(:name, :is_pc, :pl_id, images: [], nicknames_attributes: [ :id, :name, :_destroy ])
    character_params[:nicknames_attributes].each_key { |n| if character_params[:nicknames_attributes][n][:name]=="" then character_params[:nicknames_attributes][n][:_destroy]=true end }
    if character.update(character_params)
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
