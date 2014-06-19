class CharactersController < ApplicationController
  def index
    @characters = Character.all
  end

  def create
    @television_show = TelevisionShow.find(params[:television_show_id])
    @character = Character.new(character_params)
    @character.television_show = @television_show

    #binding.pry
    check = Character.find_by(name: @character.name)
    if @character.save
      flash[:notice] = "Success!"
      redirect_to "/television_shows/#{@character.television_show_id}"

    elsif @character.name.length == 0 || @character.actor.length == 0
      flash[:notice] = "Name and Actor can't be blank."
      render template: '/television_shows/show'

    elsif check !=nil
      flash[:notice] = "That character has already been taken"
      render template: '/television_shows/show'
    else
      flash.now[:notice] = "Your character couldn't be saved. Name and Actor can't be blank."
      render template: '/television_shows/show'
    end
  end

  def destroy
    #binding.pry
    @character = Character.find(params[:id])
    @show = TelevisionShow.find(@character[:television_show_id])
    if @character.destroy
      flash.now[:notice] = "Character deleted"
      redirect_to "/television_shows/#{@show.id}"
    else
      flash.now[:notice] = "Character could not be deleted"
    end
  end

  private

  def character_params
    params.require(:character).permit(:name, :actor, :description)
  end
end
