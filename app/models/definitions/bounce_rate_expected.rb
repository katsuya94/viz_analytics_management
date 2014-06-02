class BounceRateExpected < Calculated

	self.lifetime = 7

	depends_on :sessions_percent_social

	def self.calculate(sources)
		100.0 * (0.2278 * sources[:sessions_percent_social] / 100.0 + 0.6562)
	end

end