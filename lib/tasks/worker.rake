require 'typhoeus'
require 'json'

namespace :worker do
	desc 'Update calculated data if old'
	task :update_calculated => :environment do
		Dir['app/models/definitions/*'].map { |f| File.basename(f, '.rb').camelize.constantize } # Constantize all subclasses (needed to call Raw.subclasses)
		list = Calculated.subclasses + Percentile.subclasses
		list.each do |m|
			puts m.name
			Company.all.each do |c|
				m.get_datum(c)
			end
		end
	end

	desc 'Update all raw data if old'
	task :update_raw => :environment do
		Dir['app/models/definitions/*'].map { |f| File.basename(f, '.rb').camelize.constantize } # Constantize all subclasses (needed to call Raw.subclasses)
		Raw.subclasses.each do |m|
			instance = m.first
			puts "vizanalytics.herokuapp.com/#{m.url}"
			response = Typhoeus.post("vizanalytics.herokuapp.com/#{m.url}", body: { password: ENV['GETTER_PASSWORD'] })
			next unless response.success?
			data = JSON.parse response.body
			data.each_pair do |key, value|
				c = Company.find_by_url(key)
				next if c.nil?

				recent = instance.recents.with_company(c).first
				
				if recent.nil?
					recent = Recent.new :metric => instance
				elsif not recent.datum.old?
					next
				end

				new_datum = Datum.new :value => value, :metric => instance, :company => c, :previous => recent.datum
				new_datum.save

				recent.datum = new_datum
				recent.save
			end
		end
	end
end
