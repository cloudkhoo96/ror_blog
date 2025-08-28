class CommentRating < ApplicationRecord

  belongs_to :user, optional: true
  belongs_to :comment, counter_cache: true
end