# frozen_string_literal: true

module DateInterval
  module Filter
    class Operator
      def apply(dates)
        operator == "-" ? negative(dates) : positive(dates)
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
