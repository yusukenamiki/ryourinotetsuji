class HomeController < ApplicationController
  def index
    @search_recipes = @search.result.order("updated_at DESC").page(params[:page]).per(3)
  end
end
