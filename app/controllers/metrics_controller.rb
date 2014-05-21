class MetricsController < ApplicationController

	before_action :authenticate_user!

	def dashboard
	end

	def details
	end

	def metric
		c = current_user.company
		m = Metric.find(params[:metric]).class
		d = m.get_datum(c)
		render :json => { :timestamp => d.created_at, :value => d.value }
	end
end
