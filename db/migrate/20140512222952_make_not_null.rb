class MakeNotNull < ActiveRecord::Migration
  def change
  	change_column :data, :metric_id, :integer, :null => false
  	change_column :data, :company_id, :integer, :null => false
  	change_column :recents, :metric_id, :integer, :null => false
  	change_column :recents, :datum_id, :integer, :null => false
  end
end
