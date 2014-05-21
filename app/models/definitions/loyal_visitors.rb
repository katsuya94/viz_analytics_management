class LoyalVisitors < Calculated

	self.lifetime = 7

	depends_on :session_count_one
	depends_on :session_count_two
	depends_on :session_count_three
	depends_on :session_count_four
	depends_on :session_count_total

	def self.calculate(sources)
		100.0 * (sources[:session_count_total] - sources[:session_count_one] - sources[:session_count_two] - sources[:session_count_three] - sources[:session_count_four]) / sources[:session_count_total]
	end

end