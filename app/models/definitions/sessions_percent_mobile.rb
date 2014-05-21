class SessionsPercentMobile < Calculated

	self.lifetime = 7

	depends_on :sessions_mobile
	depends_on :session_count_total

	def self.calculate(sources)
		100.0 * sources[:sessions_mobile] / sources[:session_count_total]
	end

end