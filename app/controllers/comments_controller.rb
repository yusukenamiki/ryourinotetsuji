class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      redirect_to [@recipe]
    else
      render 'recipes/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(recipe_id: params[:recipe_id])
  end
end
