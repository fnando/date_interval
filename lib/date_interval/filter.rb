module DateInterval
  module Filter
    def self.filter(dates, filters)
      filters.each do |filter|
        filter.apply(dates)
      end

      dates
        .select(&:add?)
        .map(&:to_date)
        .uniq
        .sort
    end
  end
end
