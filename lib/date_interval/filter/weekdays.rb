module DateInterval
  module Filter
    class Weekdays < Operator
      attr_reader :operator

      def initialize(operator)
        @operator = operator
      end

      def filter(dates)
        dates.select(&:weekday?)
      end
    end
  end
end
