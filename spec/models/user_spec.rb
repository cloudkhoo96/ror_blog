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
  end
end
