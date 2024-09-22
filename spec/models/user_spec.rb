require 'rails_helper'

RSpec.describe User, type: :model do
  context 'associations' do
    it { should have_many(:articles).dependent(:nullify) }
    it { should have_many(:comments).dependent(:nullify) }
  end

  context 'validations' do
    let!(:existing_user) { create(:user) } 

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
    it { should allow_value('validemail@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }
  end

  context 'methods' do
    let(:user) { create(:user, username: 'testuser', email: 'test@example.com') }

    describe '#login' do
      it 'returns username if present' do
        expect(user.login).to eq('testuser')
      end

      it 'returns email if username is not present' do
        user.username = nil
        expect(user.login).to eq('test@example.com')
      end
    end

    describe '#validate_username' do
      it 'adds an error if the username matches an existing email' do
        existing_user = create(:user, email: 'test@example.com')
        user_with_conflicting_username = build(:user, username: 'test@example.com')

        user_with_conflicting_username.validate

        expect(user_with_conflicting_username.errors[:username]).to include('is invalid')
      end

      it 'does not add an error if the username is unique' do
        create(:user, email: 'test@example.com')
        user_with_unique_username = build(:user, username: 'uniqueusername')

        user_with_unique_username.validate

        expect(user_with_unique_username.errors[:username]).to be_empty
      end
    end
  end
end
