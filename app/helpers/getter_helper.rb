require 'typhoeus'
require 'json'

module GetterHelper

	def self.get(metric, url)
		response = Typhoeus.get("vizanalytics.herokuapp.com/#{metric}")
		return nil unless response.success?
		data = JSON.parse response.body
		return data[url]
	end

end