class AllowNullUserIdInArticles < ActiveRecord::Migration[7.1]
  def change
    change_column_null :articles, :user_id, true
  end
end
