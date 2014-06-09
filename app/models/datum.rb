require 'date'

# Represents a single unit of data.

class Datum < ActiveRecord::Base

	belongs_to :company
	belongs_to :metric
	belongs_to :previous, :class_name => 'Datum'
	has_one :recent

	# Check whether this datum is old.

	def old?
		lifetime = self.metric.class.lifetime
		Date.today - self.created_at.to_date > lifetime
	end

	before_destroy do |d|
		if d.recent
			d.recent.datum = d.previous
			d.recent.save
		end
	end

end
