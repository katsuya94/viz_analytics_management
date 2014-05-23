class BounceRateMobilePercentile < Percentile

	self.lifetime = 7

	references :bounce_rate_mobile
	direction :minimize

end