class RemoveLifetimeFromMetrics < ActiveRecord::Migration
  def change
    remove_column :metrics, :lifetime, :string
  end
end
