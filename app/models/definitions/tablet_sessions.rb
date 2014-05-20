class TabletSessions < Raw

	self.lifetime = 7

	def self.get_value(company)
		value = (GetterHelper::get 'tabletsessions', company.url)
		return nil unless value
		return value.to_f
	end

end