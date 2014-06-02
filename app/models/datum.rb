require 'date'

class Datum < ActiveRecord::Base

	belongs_to :company
	belongs_to :metric
	belongs_to :previous, :class_name => 'Datum'
	has_one :recent

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

	def self.oldest(metric, company)
		d = metric.get_datum(company)
		return nil unless d
		while d.previous
			d = d.previous
		end
		d
	end

end
