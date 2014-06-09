require 'typhoeus'
require 'json'

module GetterHelper

	def self.get(metric, url)
		response = Typhoeus.post("vizanalytics.herokuapp.com/#{metric}", body: { password: ENV['GETTER_PASSWORD'] })
		return nil unless response.success?
		data = JSON.parse(response.body)
		return data[url]
	end

end