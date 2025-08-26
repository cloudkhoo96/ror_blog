class CreateCommentRating < ActiveRecord::Migration[7.1]
  def change
    create_table :comment_ratings do |t|
      t.references :comment, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
