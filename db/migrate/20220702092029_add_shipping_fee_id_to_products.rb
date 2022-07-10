class AddShippingFeeIdToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :shipping_fee_id, :integer
  end
end
