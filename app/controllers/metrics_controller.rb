class MetricsController < ApplicationController
	def dashboard
	end

	def details
	end

	def metric
		c = Company.find(params[:company])
		m = Metric.find(params[:metric]).class
		d = m.get_datum(c)
		render :json => { :timestamp => d.created_at, :value => d.value }
	end
end
