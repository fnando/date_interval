module DateInterval
  class Transformer < Parslet::Transform
    rule(interval: {starting: simple(:starting), ending: simple(:ending)}) {
      (::Date.parse(starting)..::Date.parse(ending)).map {|date| Date.new(date) }
    }

    rule(weekday: {operator: simple(:operator), day: simple(:day)}) {
      Filter::Weekday.new(day.to_s, operator.to_s)
    }

    rule(date: {operator: simple(:operator), date: simple(:date)}) {
      Filter::Date.new(::Date.parse(date), operator.to_s)
    }

    rule(weekend: {operator: simple(:operator)}) {
      Filter::Weekend.new(operator.to_s)
    }

    rule(weekdays: {operator: simple(:operator)}) {
      Filter::Weekdays.new(operator.to_s)
    }

    rule(holidays: {operator: simple(:operator)}) {
      Filter::Holidays.new(operator.to_s)
    }

    rule(none: simple(:name)) {
      Filter::None.new
    }
  end
end
