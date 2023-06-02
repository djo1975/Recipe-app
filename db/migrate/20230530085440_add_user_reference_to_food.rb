class AddUserReferenceToFood < ActiveRecord::Migration[7.0]
  def change
    add_reference :foods, :author, null: false, foreign_key: { to_table: :users }
  end
end
