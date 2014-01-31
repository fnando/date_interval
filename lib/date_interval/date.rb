module DateInterval
  class Date
    attr_reader :date

    extend Forwardable
    def_delegators :date, :wday, :strftime

    def initialize(date)
      @date = date
      @add = true
    end

    def add?
      @add
    end

    def add!
      @add = true
    end

    def remove!
      @add = false
    end

    def weekend?
      [0, 6].include?(date.wday)
    end

    def weekday?
      !weekend?
    end

    def to_date
      date
    end
  end
end
