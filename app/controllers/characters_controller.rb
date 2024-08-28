class CharactersController < ApplicationController
  def index
    @pc = Pc.all.order(:pl)
    @pl = Pl.all.order(:name)
  end

  def show
  end

  def new
    @pc = Pc.new
    @pl = Pl.new
  end

  def create_pc
    @pc = Pc.new(params.require(:pc).permit(:name, :pl))
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
  end

  def update
  end

  def destroy
  end
end
