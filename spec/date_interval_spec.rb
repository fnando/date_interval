require "spec_helper"

describe DateInterval do
  it "parses the interval" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05")
    expected_interval = date_range("2014-01-01", "2014-01-05")

    expect(interval).to eql(expected_interval)
  end

  it "parses multiple intervals" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, 2014-01-06 - 2014-01-10")
    expected_interval = date_range("2014-01-01", "2014-01-10")

    expect(interval).to eql(expected_interval)
  end

  it "filters all out" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, none")
    expect(interval).to eql([])
  end

  it "includes weekends" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, none, +weekends")
    expected_interval = date_range("2014-01-04", "2014-01-05")

    expect(interval).to eql(expected_interval)
  end

  it "excludes weekends" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, -weekends")
    expected_interval = date_range("2014-01-01", "2014-01-03")

    expect(interval).to eql(expected_interval)
  end

  it "includes weekdays" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, none, +weekdays")
    expected_interval = date_range("2014-01-01", "2014-01-03")

    expect(interval).to eql(expected_interval)
  end

  it "excludes weekdays" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, -weekdays")
    expected_interval = date_range("2014-01-04", "2014-01-05")

    expect(interval).to eql(expected_interval)
  end

  it "includes date" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, +2014-01-06")
    expected_interval = date_range("2014-01-01", "2014-01-06")

    expect(interval).to eql(expected_interval)
  end

  it "excludes date" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, -2014-01-05")
    expected_interval = date_range("2014-01-01", "2014-01-04")

    expect(interval).to eql(expected_interval)
  end

  it "includes sunday" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, none, +sunday")
    expected_interval = [to_date("2014-01-05")]

    expect(interval).to eql(expected_interval)
  end

  it "excludes sunday" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, -sunday")
    expected_interval = date_range("2014-01-01", "2014-01-04")

    expect(interval).to eql(expected_interval)
  end

  it "includes monday" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-06, none, +monday")
    expected_interval = [to_date("2014-01-06")]

    expect(interval).to eql(expected_interval)
  end

  it "excludes monday" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-06, -monday")
    expected_interval = date_range("2014-01-01", "2014-01-05")

    expect(interval).to eql(expected_interval)
  end

  it "includes tuesday" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-07, none, +tuesday")
    expected_interval = [to_date("2014-01-07")]

    expect(interval).to eql(expected_interval)
  end

  it "excludes tuesday" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-07, -tuesday")
    expected_interval = date_range("2014-01-01", "2014-01-06")

    expect(interval).to eql(expected_interval)
  end

  it "includes wednesday" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, none, +wednesday")
    expected_interval = [to_date("2014-01-01")]

    expect(interval).to eql(expected_interval)
  end

  it "excludes wednesday" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, -wednesday")
    expected_interval = date_range("2014-01-02", "2014-01-05")

    expect(interval).to eql(expected_interval)
  end

  it "includes thursday" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, none, +thursday")
    expected_interval = [to_date("2014-01-02")]

    expect(interval).to eql(expected_interval)
  end

  it "excludes thursday" do
    interval = DateInterval.parse("2014-01-02 - 2014-01-05, -thursday")
    expected_interval = date_range("2014-01-03", "2014-01-05")

    expect(interval).to eql(expected_interval)
  end

  it "includes friday" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, none, +friday")
    expected_interval = [to_date("2014-01-03")]

    expect(interval).to eql(expected_interval)
  end

  it "excludes friday" do
    interval = DateInterval.parse("2014-01-03 - 2014-01-05, -friday")
    expected_interval = date_range("2014-01-04", "2014-01-05")

    expect(interval).to eql(expected_interval)
  end

  it "includes saturday" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-04, none, +saturday")
    expected_interval = [to_date("2014-01-04")]

    expect(interval).to eql(expected_interval)
  end

  it "excludes saturday" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-04, -saturday")
    expected_interval = date_range("2014-01-01", "2014-01-03")

    expect(interval).to eql(expected_interval)
  end

  it "returns unique dates" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-02, +2014-01-02")
    expected_interval = date_range("2014-01-01", "2014-01-02")

    expect(interval).to eql(expected_interval)
  end

  it "returns sorted dates" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-02, +2013-12-31")
    expected_interval = date_range("2013-12-31", "2014-01-02")

    expect(interval).to eql(expected_interval)
  end

  it "excludes holidays" do
    DateInterval::Filter::Holidays.add Date.parse("2014-01-01")

    interval = DateInterval.parse("2014-01-01 - 2014-01-02, -holidays")
    expected_interval = [to_date("2014-01-02")]

    expect(interval).to eql(expected_interval)
  end

  it "includes holidays" do
    DateInterval::Filter::Holidays.add Date.parse("2014-01-01")

    interval = DateInterval.parse("2014-01-01 - 2014-01-02, none, +holidays")
    expected_interval = [to_date("2014-01-01")]

    expect(interval).to eql(expected_interval)
  end
end
