class BounceRatePercentile < Percentile

	self.lifetime = 7

	references :bounce_rate
	direction :minimize

end