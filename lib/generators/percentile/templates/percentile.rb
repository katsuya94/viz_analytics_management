class <%= class_name %>Percentile < Percentile

	self.lifetime = 7

	references :<%= class_name.underscore %>

end