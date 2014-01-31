module DateInterval
  class Parser < Parslet::Parser
    rule(:date)  { year >> hyphen >> month >> hyphen >> day }

    rule(:year)  {
      match("[12]") >> match("[0-9]").repeat(3)
    }

    rule(:month) {
      str("0") >> match("[1-9]") |
      str("1") >> match("[0-2]")
    }

    rule(:day)   {
      str("0") >> match("[1-9]")      |
      match("[12]") >> match("[0-9]") |
      str("3") >> match("[01]")
    }

    rule(:comma)              { str(",") >> space? }
    rule(:hyphen)             { str("-") }
    rule(:hyphen_with_space)  { space? >> hyphen >> space? }

    rule(:space)  { match(" ").repeat(1) }
    rule(:space?) { space.maybe }

    rule(:interval)  {
      (date.as(:starting) >> hyphen_with_space >> date.as(:ending)).as(:interval)
    }

    rule(:intervals) {
      interval >>
      ((comma >> interval).repeat).maybe
    }

    rule(:filters)  { (comma >> filter).repeat }
    rule(:filters?) { filters.maybe }
    rule(:filter)   {
      filter_weekday.as(:weekday)   |
      filter_weekdays.as(:weekdays) |
      filter_weekend.as(:weekend)   |
      filter_none.as(:none)         |
      filter_date.as(:date)         |
      filter_holidays.as(:holidays)
    }

    rule(:s?) { str("s").maybe }

    rule(:filter_holidays) {
      operator? >>
      str("holiday") >> s?
    }

    rule(:filter_weekend) {
      operator? >>
      str("weekend") >> s?
    }

    rule(:filter_weekdays)   {
      operator? >>
      str("weekday") >> s?
    }

    rule(:filter_weekday)   {
      operator? >>
      (
        str("sunday")     |
        str("monday")     |
        str("tuesday")    |
        str("wednesday")  |
        str("thursday")   |
        str("friday")     |
        str("saturday")
      ).as(:day) >> s?
    }

    rule(:filter_none)  {
      str("none")
    }

    rule(:filter_date) {
      operator? >>
      date.as(:date)
    }

    rule(:operator)   { match("[+-]").as(:operator) }
    rule(:operator?)  { operator.maybe }

    rule(:expression) {
      intervals.as(:intervals) >>
      filters?.as(:filters)
    }

    root :expression
  end
end
