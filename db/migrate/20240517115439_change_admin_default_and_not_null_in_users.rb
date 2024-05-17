class ChangeAdminDefaultAndNotNullInUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :admin, false
    change_column_null :users, :admin, false
  end
end
