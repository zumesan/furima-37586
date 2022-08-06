class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :text
      t.integer :user_id
      t.integer :product_id

      t.timestamps
    end
  end
end
