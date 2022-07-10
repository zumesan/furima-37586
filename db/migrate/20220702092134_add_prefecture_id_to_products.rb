class AddPrefectureIdToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :prefecture_id, :integer
  end
end
