json.extract! customer, :id, :customer_code, :company_name, :address1, :address2, :address3, :eircode, :user_id, :created_at, :updated_at
json.url customer_url(customer, format: :json)
