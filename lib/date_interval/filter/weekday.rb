module DateInterval
  module Filter
    class Weekday < Operator
      attr_reader :day, :operator, :wday

      WEEKDAYS = %w[sunday monday tuesday wednesday thursday friday saturday]

      def initialize(day, operator)
        @day = day
        @wday = WEEKDAYS.index(day)
        @operator = operator
      end

      def filter(dates)
        dates.select {|date| date.wday == wday }
      end

      def positive(dates)
        filter(dates).each(&:add!)
      end

      def negative(dates)
        filter(dates).each(&:remove!)
      end
    end
  end
end
