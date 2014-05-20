class Percentile < Metric

	class_attribute :reference

	def self.references(classname)
		self.reference = classname.to_s.classify.constantize
	end

	def self.get_value(company)
		Company.all.each { |c| self.reference.get_datum(c) }
		datum = self.reference.get_datum(company)
		total = self.reference.first.recents.size
		below = self.reference.first.recents.joins(:datum).where('"data"."value" < ?', datum.value).size
		100.0 * below.to_f / total.to_f
	end

end