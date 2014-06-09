# Dashboard and in-depth metrics.

# jQuery AJAX calls are used to dynamicly load the value of metrics into bootstrap as defined in app/assets/javascripts/metrics.js.

class MetricsController < ApplicationController

	before_action :authenticate_user!

	# Top-level metrics.

	def dashboard
	end

	# In-depth metrics.

	def engagement
	end

	# Returns datum in JSON form for use with AJAX.

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
