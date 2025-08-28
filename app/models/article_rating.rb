class ArticleRating < ApplicationRecord

  belongs_to :user, optional: true
  belongs_to :article, counter_cache: true
end