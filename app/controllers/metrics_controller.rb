class MetricsController < ApplicationController

	before_action :authenticate_user!

	def dashboard
	end

	def engagement
	end

	def acquisition
	end

	def platform
	end

	def metric
		c = current_user.company
		m = Metric.find(params[:metric]).class
		d = m.get_datum(c)
		if d.nil?
			render :nothing => true, :status => 404
		else
			render :json => { :timestamp => d.created_at, :value => d.value }
		end
	end
end
