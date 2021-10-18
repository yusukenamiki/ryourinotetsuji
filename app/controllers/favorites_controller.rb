class FavoritesController < ApplicationController
  def index
    @recipes = Recipe.joins(:favorites).where(favorites: { user_id: params[:user_id] }).page(params[:page])
  end

  def create
    @favorite = current_user.favorites.create(recipe_id: params[:recipe_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @favorite = current_user.favorites.find_by(recipe_id: @recipe.id)
    @favorite.destroy
    redirect_back(fallback_location: root_path)
  end
end
