class HomeController < ApplicationController
  def index
    @search_recipes = @search.result.order("updated_at DESC").page(params[:page]).per(3)
    recipes = Recipe.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    @recipes = Kaminari.paginate_array(recipes).page(params[:page]).per(3)
  end
end
