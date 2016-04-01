require "bundler/setup"
require "date_interval"

require "minitest/utils"
require "minitest/autorun"

module Minitest
  class Test
    def date_range(starting, ending)
      (to_date(starting)..to_date(ending)).to_a
    end

    def to_date(literal)
      Date.parse(literal)
    end
  end
end
