class AddStateIdToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :state_id, :integer
  end
end
