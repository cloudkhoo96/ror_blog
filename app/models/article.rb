class Article < ApplicationRecord
  include Visible

  belongs_to :user, optional: true

  has_many :comments, dependent: :destroy
  has_many :article_ratings, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
end
