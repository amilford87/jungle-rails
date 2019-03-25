require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    cat1 = Category.new name: 'Whatever'
    product = cat1.products.new
    product.name = 'product'
    product.price = 999.00
    product.quantity = 45

    it 'is valid with valid attributes' do
      expect(product).to be_valid
    end

    it 'is not valid without a name' do
      product.name = nil
      expect(product).to_not be_valid
    end

    it 'is not valid without a price' do
      product.price = nil
      expect(product).to_not be_valid
    end

    it 'is not valid without a quantity' do
      product.quantity = nil
      expect(product).to_not be_valid
    end

    it 'is not valid without a category' do
      product.category = nil
      expect(product).to_not be_valid
    end
  end
end
