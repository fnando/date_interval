module DateInterval
  module Filter
    class Weekend < Operator
      attr_reader :operator

      def initialize(operator)
        @operator = operator
      end

      def filter(dates)
        dates.select(&:weekend?)
      end

      def negative(dates)
        filter(dates).each(&:remove!)
      end

      def positive(dates)
        filter(dates).each(&:add!)
      end
    end
  end
end
