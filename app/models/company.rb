class Company < ActiveRecord::Base

	has_many :data, :dependent => :destroy
	has_many :recents, :dependent => :destroy
	has_one :user

end
