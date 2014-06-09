class HistoryController < ApplicationController

	def setup(title, units, suffix)
		@c = current_user.company
		@series = []
		@title = title
		@units = units
		@suffix = suffix
		@average = nil
	end

	def add(metric)
		@series << { :data => metric.past(@c).order(:created_at).map { |d| [d.created_at.utc.to_i * 1000, d.value] } }
	end

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
