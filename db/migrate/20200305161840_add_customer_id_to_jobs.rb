class AddCustomerIdToJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :customer_id, :integer
  end
end
