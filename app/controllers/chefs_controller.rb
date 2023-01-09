class ChefsController < ApplicationController
  def show
    @chef = Chef.find(permitted_params[:id])
  end

  def update
    chef = Chef.find(permitted_params[:id])
    dish = Dish.find(permitted_params[:dish_id])

    chef.dishes << dish 
    redirect_to "/chefs/#{permitted_params[:id]}"
  end

  private 

  def permitted_params
    params.permit(:id, :dish_id)
  end
end