require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end
  describe "relationships" do
    it {should belong_to :chef}
    it {should have_many :dish_ingredients}
    it {should have_many(:ingredients).through(:dish_ingredients)}
  end

  describe 'instance methods' do 
    before :each do 
      @chef_1 = Chef.create!(name: "Gordon Ramsey")
  
      @dish_1 = Dish.create!(name: "Cheese Pizza", description: "Pizza dough with red sauce and cheese", chef_id: @chef_1.id)
  
      @ingredient_1 = Ingredient.create!(name: "Dough", calories: 430)
      @ingredient_2 = Ingredient.create!(name: "Red Sauce", calories: 150)
      @ingredient_3 = Ingredient.create!(name: "Mozerella Cheese", calories: 260)
      @ingredient_4 = Ingredient.create!(name: "Pineapple", calories: 160)
  
      @dish_1.ingredients << @ingredient_1
      @dish_1.ingredients << @ingredient_2
      @dish_1.ingredients << @ingredient_3
    end

    it 'returns the total calories of all ingredients combines' do 
      expect(@dish_1.total_calories).to eq(840)
    end
  end
end 