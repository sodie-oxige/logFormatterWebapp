class CharactersController < ApplicationController
  def index
    @pl = Pl.all.order(:name)
  end

  def new
    @pc = Pc.new
    @pl = Pl.new
  end

  def create_pc
    pp params
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
end
