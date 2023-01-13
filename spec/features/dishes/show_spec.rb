require 'rails_helper'

RSpec.describe 'the dishes show page' do
  before :each do 
    @chef_1 = Chef.create!(name: "Gordon Ramsey")
    @chef_2 = Chef.create!(name: "Guy Fieri")

    @dish_1 = Dish.create!(name: "Cheese Pizza", description: "Pizza dough with red sauce and cheese", chef_id: @chef_1.id)

    @ingredient_1 = Ingredient.create!(name: "Dough", calories: 430)
    @ingredient_2 = Ingredient.create!(name: "Red Sauce", calories: 150)
    @ingredient_3 = Ingredient.create!(name: "Mozerella Cheese", calories: 260)
    @ingredient_4 = Ingredient.create!(name: "Pineapple", calories: 160)

    @dish_1.ingredients << @ingredient_1
    @dish_1.ingredients << @ingredient_2
    @dish_1.ingredients << @ingredient_3
  end

  describe 'user story 1' do 
    it 'displays the dishes attributes and all ingredients for the dish' do
      visit "/dishes/#{@dish_1.id}"

      expect(page).to have_content("Dish Name: #{@dish_1.name}")
      expect(page).to have_content("Dish Description: #{@dish_1.description}")
      expect(page).to have_content(@ingredient_1.name)
      expect(page).to have_content(@ingredient_2.name)
      expect(page).to have_content(@ingredient_3.name)
      expect(page).to_not have_content(@ingredient_4.name)
    end
     
    it 'displays a total calorie count for the dish' do 
      visit "/dishes/#{@dish_1.id}"

      expect(page).to have_content(@dish_1.total_calories)
    end

    it 'displays the chefs name' do 
      visit "/dishes/#{@dish_1.id}"

      expect(page).to have_content("Chef: #{@chef_1.name}")
      expect(page).to_not have_content("Chef: #{@chef_2.name}")
    end
  end

  describe 'user story 2 (updated version)' do 
    it 'displays a form to add an existing ingredient to that dish and redirects back to the show page' do
      visit "/dishes/#{@dish_1.id}"

      expect(page).to_not have_content(@ingredient_4.name)
  
      fill_in "Ingredient", with: @ingredient_4.id
      click_button "Submit"

      expect(current_path).to eq("/dishes/#{@dish_1.id}")
      expect(page).to have_content(@ingredient_4.name)
    end
  end
end