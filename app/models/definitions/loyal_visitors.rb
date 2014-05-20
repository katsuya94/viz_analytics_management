class LoyalVisitors < Calculated

	depends_on :one_session_count
	depends_on :two_session_count
	depends_on :three_session_count
	depends_on :four_session_count
	depends_on :total_session_count

	def self.calculate(sources)
		100.0 * (sources[:total_session_count] - sources[:one_session_count] - sources[:two_session_count] - sources[:three_session_count] - sources[:four_session_count]) / sources[:total_session_count]
	end

end