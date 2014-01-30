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
    end
  end
end
