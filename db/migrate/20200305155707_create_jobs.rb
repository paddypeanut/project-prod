class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.text :customer_code
      t.integer :parcels
      t.integer :pallets
      t.integer :bundles
      t.integer :user_id

      t.timestamps
    end
  end
end
