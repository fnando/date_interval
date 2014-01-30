module DateInterval
  module Filter
    class Weekend < Operator
      attr_reader :operator

      def initialize(operator)
        @operator = operator
      end

      def negative(dates)
        dates
          .select(&:weekend?)
          .each(&:remove!)
      end

      def positive(dates)
        dates
          .select(&:weekend?)
          .each(&:add!)
      end
    end
  end
end
