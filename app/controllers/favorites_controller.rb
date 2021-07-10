class FavoritesController < ApplicationController

  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def index
    @favorites = Favorite.all
  end

  def create
    favorite = current_user.favorites.create(picture_id: params[:picture_id])
    redirect_to pictures_path, notice: "#{favorite.picture.user.name}Favo★Completion"
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to pictures_path, notice: "#{favorite.picture.user.name}Favo★TheEnd "
  end
end
