class BounceRateTen < Calculated

	depends_on :bounce_rate

	self.lifetime = 5

	def self.calculate(sources)
		sources[:bounce_rate] * 10
	end

end