class AddJobMonthToJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :job_month, :string
  end
end
