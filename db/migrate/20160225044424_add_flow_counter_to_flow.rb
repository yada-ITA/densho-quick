class AddFlowCounterToFlow < ActiveRecord::Migration
  def change
    add_column :flows, :flow_counter, :integer
  end
end
