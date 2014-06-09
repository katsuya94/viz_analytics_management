# Landing Page.

class GuestController < ApplicationController

	# Landing Page.

	def home
		if user_signed_in?
			redirect_to :controller => 'metrics', :action => 'dashboard'
		end
	end

end
