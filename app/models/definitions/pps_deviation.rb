class PpsDeviation < Calculated

	depends_on :pps
	depends_on :pps_expected

	def self.calculate(sources)
		(sources[:pps] - sources[:pps_expected]) / sources[:pps_expected]
	end

end