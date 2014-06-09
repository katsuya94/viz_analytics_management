# Metric that take values directly from the Getter Server

class Raw < Metric

	class_attribute :url

	# Defines the referenced url on the getter server.

	def self.references(url)
		self.url = url
	end

	def self.get_value(company)
		value = (GetterHelper::get self.url, company.url)
		return nil unless value
		return value.to_f
	end

end