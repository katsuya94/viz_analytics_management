class Raw < Metric

	class_attribute :url

	def self.references(url)
		self.url = url
	end

	def self.get_value(company)
		value = (GetterHelper::get self.url, company.url)
		return nil unless value
		return value.to_f
	end

end