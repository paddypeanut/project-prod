class Customer < ApplicationRecord
	belongs_to :user
	has_many :jobs
end
