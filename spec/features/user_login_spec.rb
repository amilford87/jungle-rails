require 'rails_helper'

RSpec.feature "Visitor navigates to home page", type: :feature, js: true do

  # SETUP
  before :each do
    @user = User.create!(firstname: 'Test', lastname: 'Man', email: 'testman@test.com', password: 'password1', password_confirmation: 'password1')
  end

  scenario "They go to the login page" do
    visit login_path
    fill_in 'email', with: 'testman@test.com'
    fill_in 'password', with: 'password1'

    within('main') {click_on 'Login'}
    
    # commented out b/c it's for debugging only
    # save_and_open_screenshot
    
    expect(page).to have_content 'Test'
    save_screenshot
  end
end