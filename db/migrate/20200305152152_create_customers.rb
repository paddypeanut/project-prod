class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.text :customer_code
      t.text :company_name
      t.text :address1
      t.text :address2
      t.text :address3
      t.text :eircode
      t.integer :user_id

      t.timestamps
    end
  end
end
