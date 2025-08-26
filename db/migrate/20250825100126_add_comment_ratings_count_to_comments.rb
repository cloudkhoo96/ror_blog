class AddCommentRatingsCountToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :comment_ratings_count, :integer, default:0, null: false
  end
end
