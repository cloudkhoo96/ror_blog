require 'rails_helper'

RSpec.describe Article, type: :model do
  # pure rpsec
  it "should validate title presence true" do
    article = Article.new(title: nil, body: "ye")
    expect(article.valid?).to eq(false)
  end
  
  # shoulda matchers
  context 'associations' do
    it { should belong_to(:user).optional }
    it { should have_many(:comments).dependent(:destroy) }
  end

  context 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
    it do 
      should validate_length_of(:body).is_at_least(10)
    end
  end

  context 'enum' do
    it { should define_enum_for(:status).
      with_values( 
       displayed: "displayed",
       hidden: "hidden",
       archived: "archived").
      backed_by_column_of_type(:string) }
  end

  context 'class methods' do
    context 'public_count' do
      it "should display correct public count" do
        create(:article, :displayed)
        create(:article, :hidden)
        create(:article, :archived)

        expect(described_class.public_count).to eq(1)
      end
    end
  end
end