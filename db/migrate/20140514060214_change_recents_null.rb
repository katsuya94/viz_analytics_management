class ChangeRecentsNull < ActiveRecord::Migration
  def change
  	change_column :recents, :datum_id, :integer, :null => true
  end
end
