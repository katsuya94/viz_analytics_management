require 'test_helper'

class MetricTest < ActiveSupport::TestCase
	test "Metrics" do
		puts metrics(:bounce_rate).data.first.value
		puts metrics(:bounce_rate).class.get_datum(companies(:buzzfeed)).value
		puts metrics(:bounce_rate).class.get_datum(companies(:buzzfeed)).value
		puts metrics(:bounce_rate_percentile).class.get_datum(companies(:buzzfeed)).value
	end
end
