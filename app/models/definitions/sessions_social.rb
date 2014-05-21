class SessionsSocial < Raw

	self.lifetime = 7

	def self.get_value(company)
		value = (GetterHelper::get 'socialsessions', company.url)
		return nil unless value
		return value.to_f
	end

end