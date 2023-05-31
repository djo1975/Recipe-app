class ChangeUserIdToAuthorIdInFoods < ActiveRecord::Migration[7.0]
  def change
    rename_column :foods, :user_id, :author_id
  end
end
