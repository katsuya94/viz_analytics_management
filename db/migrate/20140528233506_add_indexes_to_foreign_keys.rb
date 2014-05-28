class AddIndexesToForeignKeys < ActiveRecord::Migration
  def change
  	add_index :recents, :metric_id
  	add_index :data, :company_id
  end
end
