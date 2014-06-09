# Allows Metric to define custom calculations based on a number of other metrics.

class Calculated < Metric

	class_attribute :dependencies

	# Defines dependencies

	def self.depends_on(classname)
		self.dependencies = Array.new if self.dependencies.nil?
		self.dependencies << classname.to_s.camelize.constantize
	end

	def self.get_value(company)
		sources = Hash.new
		self.dependencies.each do |d|
			datum = d.get_datum(company)
			return nil if datum.nil?
			sources[d.name.underscore.to_sym] = datum.value
		end
		return self.calculate(sources)
	end

	# Defines calculations, must return a numerical value using the hash of parent metric values.

	def self.calculate(sources)
	end

end