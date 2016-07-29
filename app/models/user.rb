class User < ActiveRecord::Base
	has_many :restaurants
	has_many :favorites, through: :restaurants, class_name: 'dishes'

	has_secure_password
end