namespace :metrics do
	desc "Instantiate all metrics"
	task init: :environment do
		Dir['app/models/definitions/*'].each { |f| File.basename(f, '.rb').camelize.constantize.singleton }
	end

end
