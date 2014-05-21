class PpsDeviation < Calculated

	self.lifetime = 7

	depends_on :pps
	depends_on :pps_expected

	def self.calculate(sources)
		100.0 * (sources[:pps] - sources[:pps_expected]) / sources[:pps_expected]
	end

end