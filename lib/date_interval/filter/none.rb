module DateInterval
  module Filter
    class None
      def apply(dates)
        dates.each(&:remove!)
      end
    end
  end
end
