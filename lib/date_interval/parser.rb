# frozen_string_literal: true

module DateInterval
  class Parser < Parslet::Parser
    rule(:date)  { year >> hyphen >> month >> hyphen >> day }

    rule(:year)  do
      match("[12]") >> match("[0-9]").repeat(3)
    end

    rule(:month) do
      str("0") >> match("[1-9]") |
        str("1") >> match("[0-2]")
    end

    rule(:day) do
      str("0") >> match("[1-9]") |
        match("[12]") >> match("[0-9]") |
        str("3") >> match("[01]")
    end

    rule(:comma)              { str(",") >> space? }
    rule(:hyphen)             { str("-") }
    rule(:hyphen_with_space)  { space? >> hyphen >> space? }

    rule(:space)  { match(" ").repeat(1) }
    rule(:space?) { space.maybe }

    rule(:interval) do
      (
        date.as(:starting) >> hyphen_with_space >> date.as(:ending)
      ).as(:interval)
    end

    rule(:intervals) do
      interval >>
        (comma >> interval).repeat.maybe
    end

    rule(:filters)  { (comma >> filter).repeat }
    rule(:filters?) { filters.maybe }
    rule(:filter)   do
      filter_weekday.as(:weekday) |
        filter_weekdays.as(:weekdays) |
        filter_weekend.as(:weekend)   |
        filter_none.as(:none)         |
        filter_date.as(:date)         |
        filter_holidays.as(:holidays)
    end

    rule(:s?) { str("s").maybe }

    rule(:filter_holidays) do
      operator? >>
        str("holiday") >> s?
    end

    rule(:filter_weekend) do
      operator? >>
        str("weekend") >> s?
    end

    rule(:filter_weekdays) do
      operator? >>
        str("weekday") >> s?
    end

    rule(:filter_weekday) do
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
    end

    rule(:filter_none) do
      str("none")
    end

    rule(:filter_date) do
      operator? >>
        date.as(:date)
    end

    rule(:operator)   { match("[+-]").as(:operator) }
    rule(:operator?)  { operator.maybe }

    rule(:expression) do
      intervals.as(:intervals) >>
        filters?.as(:filters)
    end

    root :expression
  end
end
