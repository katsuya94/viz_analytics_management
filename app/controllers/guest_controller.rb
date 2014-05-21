class GuestController < ApplicationController
  def home
  	if user_signed_in?
  		redirect_to :controller => 'metrics', :action => 'dashboard'
  	end
  end
end
