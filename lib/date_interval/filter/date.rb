module DateInterval
  module Filter
    class Date < Operator
      attr_reader :date, :operator

      def initialize(date, operator)
        @date = date
        @operator = operator
      end

      def positive(dates)
        dates << DateInterval::Date.new(date)
      end

      def negative(dates)
        dates
          .select {|d| d.to_date == date }
          .each(&:remove!)
      end
    end
  end
end
