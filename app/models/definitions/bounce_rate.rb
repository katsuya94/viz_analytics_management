class BounceRate < Raw

	self.lifetime = 7

	def self.raw(company)
		rand(0..100).to_f
	end

end