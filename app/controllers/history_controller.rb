class HistoryController < ApplicationController

	def setup(title, units, suffix)
		@c = current_user.company
		@series = []
		@title = title
		@units = units
		@suffix = suffix
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
		render 'history/index'
	end

end
