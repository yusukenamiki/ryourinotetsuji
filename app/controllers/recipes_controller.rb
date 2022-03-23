class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def show
    @recipe = Recipe.find(params[:id])
    @comment = Comment.new
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      redirect_to user_path(current_user), notice: 'レシピを投稿しました。'
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    redirect_to recipes_path, alert: '不正なアクセスです。' if @recipe.user != current_user
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), notice: 'レシピを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to user_path(current_user), notice: 'レシピを削除しました。'
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :body, :image)
  end
end
