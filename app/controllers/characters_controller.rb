class CharactersController < ApplicationController
  def index
    @characters = Character.all
  end

  def create
    @television_show = TelevisionShow.find(params[:television_show_id])
    @character = Character.new(character_params)
    @character.television_show = @television_show

    #binding.pry

    if @character.save
      flash[:notice] = "Success!"
      redirect_to '/television_shows/{#@television_show.id}'
    else
      flash.now[:notice] = "Your character couldn't be saved."
      render template: '/television_shows/show'
    end
  end

  def destroy
    @character = Character.find()
  end

  private

  def character_params
    params.require(:character).permit(:name, :actor, :description)
  end
end
