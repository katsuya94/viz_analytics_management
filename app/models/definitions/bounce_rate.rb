class BounceRate < Raw

	self.lifetime = 7

	def self.get_value(company)
		value = (GetterHelper::get 'bouncerate', company.url).to_f
		return nil if value == -1.0
		return value
	end

end