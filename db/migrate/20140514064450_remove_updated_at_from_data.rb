class RemoveUpdatedAtFromData < ActiveRecord::Migration
  def change
    remove_column :data, :updated_at, :datetime
  end
end
