class PpsPercentile < Percentile

	self.lifetime = 7

	references :pps
	direction :maximize

end