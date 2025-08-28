class CreateArticleRating < ActiveRecord::Migration[7.1]
  def change
    create_table :article_ratings do |t|
      t.references :article, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
