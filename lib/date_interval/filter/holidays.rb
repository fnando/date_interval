# frozen_string_literal: true

module DateInterval
  module Filter
    class Holidays < Operator
      attr_reader :operator

      def self.add(*dates)
        dates.map {|date| holidays << date.strftime("%s") }
      end

      def self.holidays
        @holidays ||= []
      end

      def initialize(operator) # rubocop:disable Lint/MissingSuper
        @operator = operator
      end

      def filter(dates)
        dates.select {|date| self.class.holidays.include?(date.strftime("%s")) }
      end
    end
  end
end
