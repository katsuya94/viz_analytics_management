class BounceRateDeviation < Calculated

	self.lifetime = 7

	depends_on :bounce_rate
	depends_on :bounce_rate_expected

	def self.calculate(sources)
		100.0 * (sources[:bounce_rate] - sources[:bounce_rate_expected]) / sources[:bounce_rate_expected]
	end

end