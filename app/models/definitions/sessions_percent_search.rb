class SessionsPercentSearch < Calculated

	self.lifetime = 7

	depends_on :sessions_direct
	depends_on :sessions_search
	depends_on :sessions_referral
	depends_on :sessions_social
	depends_on :sessions_email

	def self.calculate(sources)
		100.0 * sources[:sessions_search] / (sources[:sessions_direct] + sources[:sessions_search] + sources[:sessions_referral] + sources[:sessions_social] + sources[:sessions_email])
	end

end