class Percentile < Metric

	class_attribute :reference
	class_attribute :comparison

	def self.direction(symbol)
		self.comparison = '<' if symbol == :maximize
		self.comparison = '>' if symbol == :minimize
	end

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