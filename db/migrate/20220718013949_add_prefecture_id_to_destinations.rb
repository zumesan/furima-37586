class AddPrefectureIdToDestinations < ActiveRecord::Migration[6.0]
  def change
    add_column :destinations, :prefecture_id, :integer
  end
end
