# Base Metric. Gets data if current data is nonexistant/old.

# get_value must be implemented in subclasses.

class Metric < ActiveRecord::Base

	private_class_method :new

	# Lifetime must be defined for every metric, it will automatically update data if old.

	class_attribute :lifetime

	has_many :recents
	has_many :data, :through => :recents

	# Get new data if Recent is old/nonexistant.

	def self.get_datum(company)
		instance = self.first

		recent = instance.recents.with_company(company).first
		
		if recent.nil?
			recent = Recent.new :metric => instance
		elsif not recent.datum.old?
			return recent.datum
		end
		
		value = self.get_value(company)

		unless value.nil?
			new_datum = Datum.new :value => value, :metric => instance, :company => company, :previous => recent.datum
			new_datum.save
		end

		recent.datum = new_datum if defined? :new_datum
		recent.save

		return new_datum if defined? :new_datum
	end

	# Initializes a single instance.

	def self.singleton(description = nil)
		return unless self.first.nil?
		instance = new :description => (description ? description : '')
		instance.save
	end

	# Gets the average of most its recent data.

	def self.average
		self.first.data.average(:value)
	end

	# Finds the oldest datum via linked list.

	def self.oldest(company)
		d = self.get_datum(company)
		id = ActiveRecord::Base.connection.execute(self.recursive(d)).to_a.last['id']
		Datum.find(id)
	end

	# Finds all past data via linked list.

	def self.past(company)
		d = self.get_datum(company)
		Datum.where("#{Datum.table_name}.id IN (#{self.recursive(d)})")
	end

	# Recursive query.

	def self.recursive(d)
		<<-SQL
			WITH RECURSIVE recurse(id, previous_id) AS (
				SELECT #{Datum.table_name}.id, #{Datum.table_name}.previous_id
				FROM #{Datum.table_name}
				WHERE id = #{d.id}
				UNION ALL
				SELECT #{Datum.table_name}.id, #{Datum.table_name}.previous_id
				FROM recurse JOIN #{Datum.table_name} ON recurse.previous_id = #{Datum.table_name}.id
			) SELECT id FROM recurse
		SQL
	end

end