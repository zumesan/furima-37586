class CreateDestinations < ActiveRecord::Migration[6.0]
  def change
    create_table :destinations do |t|

      t.string :post_number,         null: :false
      t.string :municipality,        null: :false
      t.string :address,             null: :false
      t.string :building_name
      t.string :phone_number,        null: :false
      t.references :purchase_record, null: :false, foreign_key: :true

      t.timestamps
    end
  end
end
