require 'test_helper'

class MetricTest < ActiveSupport::TestCase
	test "Raw Metrics" do
		puts metrics(:bounce_rate).class.get_datum(companies(:buzzfeed)).value
		puts metrics(:bounce_rate).class.get_datum(companies(:buzzfeed)).value
		puts metrics(:bounce_rate_ten).class.get_datum(companies(:buzzfeed)).value
		puts BounceRate.percentile(data(:d_00))
	end
end
