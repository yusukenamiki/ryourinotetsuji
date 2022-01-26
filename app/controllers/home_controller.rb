class HomeController < ApplicationController
  def index
    @recipes = Recipe.order("updated_at DESC").page(params[:page]).per(3)
  end
end
