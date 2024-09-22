require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'associations' do
    it { should belong_to(:article) }
    it { should belong_to(:user).optional }
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
        create(:comment, :displayed)
        create(:comment, :hidden)
        create(:comment, :archived)

        expect(described_class.public_count).to eq(1)
      end
    end
  end
end
