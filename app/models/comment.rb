class Comment < ApplicationRecord
  include Visible

  belongs_to :article
  has_one :user, through: :article
end
