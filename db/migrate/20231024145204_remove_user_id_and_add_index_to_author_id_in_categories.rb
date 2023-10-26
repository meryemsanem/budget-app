class RemoveUserIdAndAddIndexToAuthorIdInCategories < ActiveRecord::Migration[7.0]
  def change
    remove_column :categories, :user_id if column_exists?(:categories, :user_id)
  end
end
