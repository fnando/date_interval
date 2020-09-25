# frozen_string_literal: true

module DateInterval
  module Filter
    class Weekdays < Operator
      attr_reader :operator

      def initialize(operator) # rubocop:disable Lint/MissingSuper
        @operator = operator
      end

      def filter(dates)
        dates.select(&:weekday?)
      end
    end
  end
end
