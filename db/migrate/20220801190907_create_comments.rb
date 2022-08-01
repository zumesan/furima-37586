class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :text
      t.interger :user_id
      t.interger :product_id

      t.timestamps
    end
  end
end
