# TODO: Half-implemented change over time visualization.

class HistoryController < ApplicationController

	before_action :authenticate_user!

	# Initializes variables needed to display highcharts.

	def setup(title, units, suffix)
		@c = current_user.company
		@series = []
		@title = title
		@units = units
		@suffix = suffix
		@average = nil
	end

	# Denotes that a metric should be present on the chart.

	def add(metric)
		@series << { :data => metric.past(@c).order(:created_at).map { |d| [d.created_at.utc.to_i * 1000, d.value] } }
	end

	# Denotes that a bar with an average for this metric should be shown.

	def average(metric)
		@average = metric.average
	end

	def bouncerate
		setup 'Bounce Rate', 'Percent', '%'
		add BounceRate
		average BounceRate
		render 'history/index'
	end

	def bouncerateplatform
		setup 'Bounce Rate by Platform', 'Percent', '%'
		add BounceRateDesktop
		add BounceRateMobile
		add BounceRateTablet
		render 'history/index'
	end

end
