class Calculated < Metric

	class_attribute :dependencies
	self.dependencies = Array.new

	def self.depends_on(classname)
		self.dependencies.push(classname.to_s.camelize.constantize)
	end

	def self.get_value(company)
		sources = Hash.new

		self.dependencies.each do |d|
			datum = d.get_datum(company)
			sources[datum.metric.class.name.underscore.to_sym] = datum.value
		end

		self.calculate(sources)
	end

	def self.calculate(sources)
	end

end