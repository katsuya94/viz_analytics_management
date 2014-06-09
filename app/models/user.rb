# Devise User.

class User < ActiveRecord::Base
	belongs_to :company

	devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
end
