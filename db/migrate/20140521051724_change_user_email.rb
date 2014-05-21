class ChangeUserEmail < ActiveRecord::Migration
  def change
  	change_column :users, :email, :text, :null => false, :default => ""
  end
end
