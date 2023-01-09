require 'rails_helper'

RSpec.describe 'the chefs ingredients show page' do
  before :each do 
    @chef_1 = Chef.create!(name: "Gordon Ramsey")
    @chef_2 = Chef.create!(name: "Guy Fieri")

    @dish_1 = Dish.create!(name: "Cheese Pizza", description: "Pizza dough with red sauce and cheese", chef_id: @chef_1.id)
    @dish_2 = Dish.create!(name: "PB&J", description: "Bread with peanut butter and jelly", chef_id: @chef_1.id)
    @dish_3 = Dish.create!(name: "Cheese Quesadilla", description: "Tortilla  with cheeze", chef_id: @chef_2.id)

    @ingredient_1 = Ingredient.create!(name: "Dough", calories: 430)
    @ingredient_2 = Ingredient.create!(name: "Red Sauce", calories: 150)
    @ingredient_3 = Ingredient.create!(name: "Mozerella Cheese", calories: 260)

    @dish_1.ingredients << @ingredient_1
    @dish_1.ingredients << @ingredient_2
    @dish_1.ingredients << @ingredient_3
    
    @ingredient_4 = Ingredient.create!(name: "Bread", calories: 100)
    @ingredient_5 = Ingredient.create!(name: "Peanut Butter", calories: 360)
    @ingredient_6 = Ingredient.create!(name: "Jelly", calories: 290)

    @dish_2.ingredients << @ingredient_4
    @dish_2.ingredients << @ingredient_5
    @dish_2.ingredients << @ingredient_6
    @dish_2.ingredients << @ingredient_3

    @ingredient_7 = Ingredient.create!(name: "Tortilla", calories: 230)
    @ingredient_8 = Ingredient.create!(name: "Queso", calories: 160)

    @dish_3.ingredients << @ingredient_7
    @dish_3.ingredients << @ingredient_8
  end
  describe 'user story 3 part 2' do 
    it 'clicking the link directs to a chefs ingredients index page where I see a unique list of ingredient names' do 
      visit "/chefs/#{@chef_1.id}"

      click_link "View All Ingredients"

      expect(current_path).to eq("/chefs/#{@chef_1.id}/ingredients")
      expect(page).to have_content(@ingredient_1.name)
      expect(page).to have_content(@ingredient_2.name)
      expect(page).to have_content(@ingredient_3.name)
      expect(page).to have_content(@ingredient_4.name)
      expect(page).to have_content(@ingredient_5.name)
      expect(page).to have_content(@ingredient_6.name)
    end
  end
end