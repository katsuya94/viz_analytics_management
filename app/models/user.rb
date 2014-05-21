class User < ActiveRecord::Base
	has_one :company

	devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
end
