require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    subject {
      described_class.new(firstname: 'John', lastname: 'Smith', email: 'example@example.com', password: '123456', password_confirmation: '123456')
    }

      it 'is valid with valid attributes' do
        expect(subject).to be_valid
      end

      it 'is not valid without a firstname' do
        subject.firstname = nil
        expect(subject).to_not be_valid
      end

      it 'is not valid without a lastname' do
        subject.lastname = nil
        expect(subject).to_not be_valid
      end

      it 'is not valid without an email' do
        subject.email = nil
        expect(subject).to_not be_valid
      end

      it 'is not valid without a unique email and is not case sensitive' do
        User.destroy_all
        @user = User.create!(firstname: 'Rick', lastname: 'Sanchez', email: 'rick@rick.com', password: 'password1', password_confirmation: 'password1')
        subject.email = 'RICK@RICK.com'
        expect(subject).to_not be_valid
      end

      it 'is not valid without a password' do
        subject.password = nil
        expect(subject).to_not be_valid
      end

      it 'is not valid without a password confirmation' do
        subject.password_confirmation = nil
        expect(subject).to_not be_valid
      end

      it 'is not valid without password confirmation matching password' do
        subject.password_confirmation = '5678'
        expect(subject).to_not be_valid
      end

      it 'is not valid without minimum password length of 4 characters' do
        subject.password = '1234'
        subject.password_confirmation = '1234'
        expect(subject).to_not be_valid
      end
  end
end
