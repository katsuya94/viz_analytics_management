class SessionsPercentTablet < Calculated

	self.lifetime = 7

	depends_on :sessions_tablet
	depends_on :session_count_total

	def self.calculate(sources)
		100.0 * sources[:sessions_tablet] / sources[:session_count_total]
	end

end