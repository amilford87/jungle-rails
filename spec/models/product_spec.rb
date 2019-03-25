require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before (:each) do
    @cat1 = Category.new name: 'Whatever'
    @cat1.save
    @product = @cat1.products.new
    @product.name = 'product'
    @product.price = 999.00
    @product.quantity = 45
    @product.save
  end
  
    it 'is valid with valid attributes' do
      expect(@product).to be_valid
    end

    it 'is not valid without a name' do
      @product.name = nil
      @product.save
      expect(@product.errors.full_messages.include? "Name can't be blank").to eql(true)
    end

    it 'is not valid without a price' do
      @product2 = @cat1.products.new(name: 'product2', quantity: 45)
      @product2.save 
      expect(@product2.errors.full_messages.include? "Price can't be blank").to eql(true)
    end

    it 'is not valid without a quantity' do
      @product.quantity = nil
      @product.save
      expect(@product.errors.full_messages.include? "Quantity can't be blank").to eql(true)
    end

    it 'is not valid without a category' do
      @product.category = nil
      @product.save
      expect(@product.errors.full_messages.include? "Category can't be blank").to eql(true)
    end
  end
end
