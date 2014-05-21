class PpsExpected < Calculated

	depends_on :sessions_percent_direct

	def self.calculate(sources)
		0.9677 * sources[:sessions_percent_direct] / 100.0 + 1.4928
	end

end