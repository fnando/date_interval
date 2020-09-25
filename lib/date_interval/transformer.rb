# frozen_string_literal: true

module DateInterval
  class Transformer < Parslet::Transform
    rule(interval: {starting: simple(:starting), ending: simple(:ending)}) do
      (
        ::Date.parse(starting)..::Date.parse(ending)
      ).map {|date| Date.new(date) }
    end

    rule(weekday: {operator: simple(:operator), day: simple(:day)}) do
      Filter::Weekday.new(day.to_s, operator.to_s)
    end

    rule(date: {operator: simple(:operator), date: simple(:date)}) do
      Filter::Date.new(::Date.parse(date), operator.to_s)
    end

    rule(weekend: {operator: simple(:operator)}) do
      Filter::Weekend.new(operator.to_s)
    end

    rule(weekdays: {operator: simple(:operator)}) do
      Filter::Weekdays.new(operator.to_s)
    end

    rule(holidays: {operator: simple(:operator)}) do
      Filter::Holidays.new(operator.to_s)
    end

    rule(none: simple(:name)) do
      Filter::None.new
    end
  end
end
