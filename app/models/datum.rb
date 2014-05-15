require 'date'

class Datum < ActiveRecord::Base

	belongs_to :company
	belongs_to :metric
	belongs_to :previous, :class_name => 'Datum'
	has_one :recent, :dependent => :destroy

	def old?
		lifetime = self.metric.class.lifetime
		Date.today - self.created_at.to_date > lifetime
	end

end
