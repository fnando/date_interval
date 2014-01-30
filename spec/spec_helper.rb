require "bundler/setup"
require "date_interval"

module SpecHelper
  def date_range(starting, ending)
    (to_date(starting)..to_date(ending)).to_a
  end

  def to_date(literal)
    Date.parse(literal)
  end
end

RSpec.configure do |config|
  config.include SpecHelper
end
