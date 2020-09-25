# frozen_string_literal: true

module DateInterval
  module Filter
    class Weekday < Operator
      attr_reader :day, :operator, :wday

      WEEKDAYS = %w[
        sunday monday tuesday wednesday thursday friday saturday
      ].freeze

      def initialize(day, operator) # rubocop:disable Lint/MissingSuper
        @day = day
        @wday = WEEKDAYS.index(day)
        @operator = operator
      end

      def filter(dates)
        dates.select {|date| date.wday == wday }
      end
    end
  end
end
