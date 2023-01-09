require 'rails_helper'

RSpec.describe 'the chefs show page' do
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

    @ingredient_7 = Ingredient.create!(name: "Tortilla", calories: 230)
    @ingredient_8 = Ingredient.create!(name: "Queso", calories: 160)

    @dish_3.ingredients << @ingredient_7
    @dish_3.ingredients << @ingredient_8
  end

  describe 'user story 2' do 
    it 'displays the chefs name and all dishes belonging to chef' do 
      visit "/chefs/#{@chef_1.id}"

      expect(page).to have_content(@chef_1.name)
      expect(page).to have_content(@dish_1.name)
      expect(page).to have_content(@dish_2.name)
      expect(page).to_not have_content(@dish_3.name)
    end
    it 'displays a form to add an existing dish to the chef and that dish is not displayed on the show page' do 
      visit "/chefs/#{@chef_1.id}"

      expect(page).to_not have_content(@dish_3.name)
      expect(page).to_not have_content(@dish_3.description)

      fill_in "Dish", with: @dish_3.id
      click_on "Add Dish"

      expect(current_path).to eq("/chefs/#{@chef_1.id}")
      expect(page).to have_content(@dish_3.name)
      # expect(page).to have_content(@dish_3.description)
    end
  end
end