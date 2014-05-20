class EmailSessions < Raw

	self.lifetime = 7

	def self.get_value(company)
		value = (GetterHelper::get 'emailsessions', company.url)
		return nil unless value
		return value.to_f
	end

end