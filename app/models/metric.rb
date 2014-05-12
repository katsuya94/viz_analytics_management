class Metric < ActiveRecord::Base

	class_attribute :lifetime

	has_many :recents
	has_many :data, :through => :recent

	def get_datum(company)
	end

	def compare(datum)
		# Return percentile
	end

end