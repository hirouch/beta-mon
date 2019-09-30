class DecksController < ApplicationController
  def new
    @deck = Deck.new
  end

  def create
    Deck.create(name: card_params[:name], user_id: current_user.id)
    redirect_to "/cards/new"
  end

  private
  def card_params
    params.require(:deck).permit(:name)
  end

end
