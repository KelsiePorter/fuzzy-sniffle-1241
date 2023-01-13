class DishIngredientsController < ApplicationController 
  def create
    DishIngredient.create(permitted_params)

    redirect_to "/dishes/#{permitted_params[:dish_id]}"
  end

  private

  def permitted_params
    params.permit(:dish_id, :ingredient_id)
  end
end