module DateInterval
  module Filter
    class Weekdays < Operator
      attr_reader :operator

      def initialize(operator)
        @operator = operator
      end

      def negative(dates)
        dates
          .select(&:weekday?)
          .each(&:remove!)
      end

      def positive(dates)
        dates
          .select(&:weekday?)
          .each(&:add!)
      end
    end
  end
end
