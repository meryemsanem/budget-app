class RemoveUserIdAndAddIndexToAuthorIdInCategories < ActiveRecord::Migration[7.0]
  def change
    remove_column :categories, :user_id
    add_index :categories, :author_id
  end
end
