class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.string :name
      t.string :prep_time
      t.string :cook_time
      t.string :description
      t.boolean :public, default: false

      t.timestamps
    end
  end
end
