class Metric < ActiveRecord::Base

	class_attribute :lifetime

	has_many :recents
	has_many :data, :through => :recent

	def self.get_datum(company)
		instance = self.first

		recent = instance.recents.with_company(company).first
		
		if recent.nil?
			recent = Recent.new :metric => instance
		elsif not recent.datum.old?
			return recent.datum.value, self.name.underscore.to_sym
		end
		
		value = get_value(company)

		new_datum = Datum.new :value => value, :metric => instance, :company => company, :previous => recent.datum
		new_datum.save

		recent.datum = new_datum
		recent.save

		return value, self.name.underscore.to_sym
	end

	def self.percentile(datum)
		instance = self.first
		above = instance.recents.joins(:datum).where('"data"."value" > ?', datum.value).size
		below = instance.recents.joins(:datum).where('"data"."value" < ?', datum.value).size
		below.to_f / (above + below).to_f
	end

end