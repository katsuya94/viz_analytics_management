namespace :data do

	desc "Generate fake data one week before the current oldest data"
	task :generate_past => :environment do
		prng = Random.new
		Dir['app/models/definitions/*'].map { |f| File.basename(f, '.rb').camelize.constantize } # Constantize all subclasses (needed to call Raw.subclasses)
		list = Raw.subclasses + Percentile.subclasses + Calculated.subclasses
		Company.all.each do |c|
			puts c.url
			list.each do |m|
				d = Datum.oldest(m, c)
				next unless d
				_d = Datum.new :value => d.value * prng.rand(0.9..1.1), :metric => d.metric, :company => d.company
				_d.save
				d.previous = _d
				d.save
			end
		end
	end

end
