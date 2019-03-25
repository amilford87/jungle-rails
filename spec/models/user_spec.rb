require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before (:each) do
      User.destroy_all
        @user = User.create!(firstname: 'John', lastname: 'Smith', email: 'example@example.com', password: 'password', password_confirmation: 'password')
    end

      it 'is valid with valid attributes' do
        expect(@user).to be_valid
      end

      it 'is not valid without a firstname' do
        @user.firstname = nil
        @user.save
        expect(@user.errors.full_messages.include? "Firstname can't be blank").to eql(true)
      end

      it 'is not valid without a lastname' do
        @user.lastname = nil
        @user.save
        expect(@user.errors.full_messages.include? "Lastname can't be blank").to eql(true)
      end

      it 'is not valid without an email' do
        @user.email = nil
        @user.save
        expect(@user.errors.full_messages.include? "Email can't be blank").to eql(true)
      end

      it 'is not valid without a unique email and is not case sensitive' do
        User.destroy_all
        @user2 = User.create!(firstname: 'Rick', lastname: 'Sanchez', email: 'rick@rick.com', password: 'password1', password_confirmation: 'password1')
        @user.email = 'RICK@RICK.com'
        @user.save
        expect(@user.errors.full_messages.include? "Email has already been taken").to eql(true)
      end

      it 'is not valid without a password' do
        @user.password = nil
        @user.save
        expect(@user.errors.full_messages.include? "Password can't be blank").to eql(true)
      end

      it 'is not valid without a password confirmation' do
        @user.password_confirmation = nil
        @user.save
        expect(@user.errors.full_messages.include? "Password confirmation can't be blank").to eql(true)
      end

      it 'is not valid without password confirmation matching password' do
        @user.password_confirmation = '5678'
        @user.save
        expect(@user.errors.full_messages.include? "Password confirmation doesn't match Password").to eql(true)
      end

      it 'is not valid without minimum password length of 4 characters' do
        @user.password = '1234'
        @user.password_confirmation = '1234'
        @user.save
        expect(@user.errors.full_messages.include? "Password is too short (minimum is 6 characters)").to eql(true)        
      end
  end

  describe '.authenticate_with_credentials' do
    before (:each) do
      User.destroy_all
      @user3 = User.create!(firstname: 'John', lastname: 'Smith', email: 'js@js.com', password: 'password1', password_confirmation: 'password1')
    end

      it 'is able to login with a matching email' do
        expect(User.authenticate_with_credentials(@user3.email, @user3.password)).to eq(@user3)
      end

      it 'should not log in with a wrong email' do
        expect(User.authenticate_with_credentials('test2@test.com', @user3.password)).to eq(nil)
      end

      it 'should not be able to log in with a wrong password' do
        expect(User.authenticate_with_credentials(@user3.email, 'password2')).to eq(nil)
      end

      it 'should be able to log in with spaces in the email' do
        expect(User.authenticate_with_credentials('  js@js.com  ', @user3.password)).to eq(@user3)
      end

      it 'should be able to log in even if in wrong case' do
        expect(User.authenticate_with_credentials('JS@js.com', @user3.password)).to eq(@user3)
      end
  end
  
end
