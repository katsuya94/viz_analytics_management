class Metric < ActiveRecord::Base

	private_class_method :new

	class_attribute :lifetime

	has_many :recents
	has_many :data, :through => :recents

	def self.get_datum(company)
		instance = self.first

		recent = instance.recents.with_company(company).first
		
		if recent.nil?
			recent = Recent.new :metric => instance
		elsif not recent.datum.old?
			return recent.datum
		end
		
		value = self.get_value(company)

		unless value.nil?
			new_datum = Datum.new :value => value, :metric => instance, :company => company, :previous => recent.datum
			new_datum.save
		else
			new_datum = nil
		end

		recent.datum = new_datum
		recent.save

		return new_datum
	end

	def self.singleton(description)
		raise 'Already instantiated' unless self.first.nil?
		instance = self.new :description => description
		instance.save
	end

end