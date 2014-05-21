class SessionsPercentDesktop < Calculated

	self.lifetime = 7

	depends_on :sessions_desktop
	depends_on :session_count_total

	def self.calculate(sources)
		100.0 * sources[:sessions_desktop] / sources[:session_count_total]
	end

end