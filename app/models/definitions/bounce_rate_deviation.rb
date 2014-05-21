class BounceRateDeviation < Calculated

	depends_on :bounce_rate
	depends_on :bounce_rate_expected

	def self.calculate(sources)
		(sources[:bounce_rate] - sources[:bounce_rate_expected]) / sources[:bounce_rate_expected]
	end

end