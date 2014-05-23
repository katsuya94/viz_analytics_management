class LoyalVisitorsPercentile < Percentile

	self.lifetime = 7

	references :loyal_visitors
	direction :maximize

end