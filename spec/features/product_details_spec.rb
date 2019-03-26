require 'rails_helper'

RSpec.feature "Visitor navigates to home page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see the product page from items selected" do
    visit root_path
    find('article.id_1 a.pull-right').click
    sleep(1.seconds)
    # commented out b/c it's for debugging only
    # save_screenshot

    expect(page).to  have_content("64.99")
    expect(page).to  have_css('article.product-detail')
  end


end