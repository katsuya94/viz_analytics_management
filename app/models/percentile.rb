# Metric that is calculated from other recent datum of the referenced metric. Accounts for metrics that should be minimized / maximized.

class Percentile < Metric

	class_attribute :reference
	class_attribute :comparison

	# Defines direction.

	def self.direction(symbol)
		self.comparison = '<' if symbol == :maximize
		self.comparison = '>' if symbol == :minimize
	end

	# Defines the referenced Metric

	def self.references(classname)
		self.reference = classname.to_s.camelize.constantize
	end

	def self.get_value(company)
		Company.all.each { |c| self.reference.get_datum(c) }
		datum = self.reference.get_datum(company)
		return nil unless datum
		total = self.reference.first.recents.size
		below = self.reference.first.recents.joins(:datum).where('"data"."value" ' + self.comparison + ' ?', datum.value).size
		return 100.0 * below.to_f / total.to_f
	end

end