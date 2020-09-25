# frozen_string_literal: true

module DateInterval
  module Filter
    class Weekend < Operator
      attr_reader :operator

      def initialize(operator) # rubocop:disable Lint/MissingSuper
        @operator = operator
      end

      def filter(dates)
        dates.select(&:weekend?)
      end
    end
  end
end
