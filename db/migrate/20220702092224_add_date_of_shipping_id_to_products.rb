class AddDateOfShippingIdToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :date_of_shipping_id, :integer
  end
end
