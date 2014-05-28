class MetricsController < ApplicationController

	before_action :authenticate_user!

	def dashboard
	end

	def details
	end

	def aggregate
		c = current_user.company
		a = Array.new
		params['q'].split.map!(&:to_i).each do |id|
			d = Metric.find(id).class.get_datum(c)
			if d.nil?
				a << { :id => id, :value => nil }
			else
				a << { :id => id, :value => d.value }
			end
		end
		render :json => a
	end
end
