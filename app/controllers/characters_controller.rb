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
    @pc = Pl.find(pc[:pl_id]).pcs.new(pc.permit(:name, :pl_id))
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
    if pc.update(params.require(:pc).permit(:name, :pl_id))
      redirect_to characters_path
    else
      pp pc.errors.details
    end
  end
end
