require "zlib"

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
    character_params = params.require(:character)
    character_params[:nicknames_attributes].each_key { |n| if character_params[:nicknames_attributes][n][:name]=="" then character_params[:nicknames_attributes][n][:_destroy]=true end }
    character_params[:compressed_text] = Zlib::Deflate.deflate(character_params[:text])
    character_params = character_params.permit(:name, :is_pc, :pl_id, :compressed_text, images: [], nicknames_attributes: [ :id, :name, :_destroy ])
    @character = User.find(character_params[:pl_id]).characters.new(character_params)

    pp @character
    if @character.save()
      redirect_to edit_character_path(@character[:id])
    else
      pp @character.errors.details
    end
  end

  def create_pl
    @pl = User.new(params.require(:user).permit(:name).merge(userid: "default", password: "default"))
    if @pl.save()
      @pl.update(userid: "default#{@pl.id}", password: "default#{@pl.id}")
      redirect_to new_character_path
    else
      pp @pl.errors.details
    end
  end

  def show
    @character = Character.find(params[:id])
    if @character.compressed_text.present?
      begin
        @character.text = Zlib::Inflate.inflate(@character.compressed_text).force_encoding("UTF-8")
      rescue Zlib::BufError => e
        # エラー時の処理。例えば空文字にするなど
        @character.text = ""
        Rails.logger.error("Error inflating compressed_text: #{e.message}")
      end
    else
      @character.text = ""
    end
    @md_text = markdown(@character.text)
  end

  def edit
    @character = Character.includes(images_attachments: :blob).find(params[:id])
    if @character.compressed_text.present?
      begin
        @character.text = Zlib::Inflate.inflate(@character.compressed_text).force_encoding("UTF-8")
      rescue Zlib::BufError => e
        # エラー時の処理。例えば空文字にするなど
        @character.text = ""
        Rails.logger.error("Error inflating compressed_text: #{e.message}")
      end
    else
      @character.text = ""
    end
  end

  def update
    character = Character.find(params[:id])
    character_params = params.require(:character)
    character_params[:nicknames_attributes].each_key { |n| if character_params[:nicknames_attributes][n][:name]=="" then character_params[:nicknames_attributes][n][:_destroy]=true end }
    character_params[:compressed_text] = Zlib::Deflate.deflate(character_params[:text])
    character_params = character_params.permit(:name, :is_pc, :pl_id, :compressed_text, images: [], nicknames_attributes: [ :id, :name, :_destroy ])
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
