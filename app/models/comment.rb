class Comment < ApplicationRecord
  include Visible

  belongs_to :article
  belongs_to :user, optional: true

  has_many :comment_ratings, dependent: :destroy
end
