namespace :worker do
	desc 'Update all data if old'
	task :update_all => :environment do
		Metric.all.each do |m|
			Company.all.each do |c|
				m.class.get_datum(c)
			end
		end
	end
end
