class User < ActiveRecord::Base
	has_many :restaurants
	has_many :dishes, through: :restaurants

	has_secure_password
end