module DateInterval
  module Filter
    class Operator
      def apply(dates)
        operator == "-" ? negative(dates) : positive(dates)
      end
    end
  end
end
