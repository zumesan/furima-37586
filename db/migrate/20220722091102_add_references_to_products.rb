class AddReferencesToProducts < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :purchase_record, foreign_key: true
  end
end
