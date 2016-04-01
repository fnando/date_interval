require "test_helper"

class DateIntervalTest < Minitest::Test
  test "parses the interval" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05")
    expected_interval = date_range("2014-01-01", "2014-01-05")

    assert_equal expected_interval, interval
  end

  test "parses multiple intervals" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, 2014-01-06 - 2014-01-10")
    expected_interval = date_range("2014-01-01", "2014-01-10")

    assert_equal expected_interval, interval
  end

  test "filters all out" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, none")
    assert_equal [], interval
  end

  test "includes weekends" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, none, +weekends")
    expected_interval = date_range("2014-01-04", "2014-01-05")

    assert_equal expected_interval, interval
  end

  test "excludes weekends" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, -weekends")
    expected_interval = date_range("2014-01-01", "2014-01-03")

    assert_equal expected_interval, interval
  end

  test "includes weekdays" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, none, +weekdays")
    expected_interval = date_range("2014-01-01", "2014-01-03")

    assert_equal expected_interval, interval
  end

  test "excludes weekdays" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, -weekdays")
    expected_interval = date_range("2014-01-04", "2014-01-05")

    assert_equal expected_interval, interval
  end

  test "includes date" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, +2014-01-06")
    expected_interval = date_range("2014-01-01", "2014-01-06")

    assert_equal expected_interval, interval
  end

  test "excludes date" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, -2014-01-05")
    expected_interval = date_range("2014-01-01", "2014-01-04")

    assert_equal expected_interval, interval
  end

  test "includes sunday" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, none, +sunday")
    expected_interval = [to_date("2014-01-05")]

    assert_equal expected_interval, interval
  end

  test "excludes sunday" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, -sunday")
    expected_interval = date_range("2014-01-01", "2014-01-04")

    assert_equal expected_interval, interval
  end

  test "includes monday" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-06, none, +monday")
    expected_interval = [to_date("2014-01-06")]

    assert_equal expected_interval, interval
  end

  test "excludes monday" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-06, -monday")
    expected_interval = date_range("2014-01-01", "2014-01-05")

    assert_equal expected_interval, interval
  end

  test "includes tuesday" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-07, none, +tuesday")
    expected_interval = [to_date("2014-01-07")]

    assert_equal expected_interval, interval
  end

  test "excludes tuesday" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-07, -tuesday")
    expected_interval = date_range("2014-01-01", "2014-01-06")

    assert_equal expected_interval, interval
  end

  test "includes wednesday" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, none, +wednesday")
    expected_interval = [to_date("2014-01-01")]

    assert_equal expected_interval, interval
  end

  test "excludes wednesday" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, -wednesday")
    expected_interval = date_range("2014-01-02", "2014-01-05")

    assert_equal expected_interval, interval
  end

  test "includes thursday" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, none, +thursday")
    expected_interval = [to_date("2014-01-02")]

    assert_equal expected_interval, interval
  end

  test "excludes thursday" do
    interval = DateInterval.parse("2014-01-02 - 2014-01-05, -thursday")
    expected_interval = date_range("2014-01-03", "2014-01-05")

    assert_equal expected_interval, interval
  end

  test "includes friday" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-05, none, +friday")
    expected_interval = [to_date("2014-01-03")]

    assert_equal expected_interval, interval
  end

  test "excludes friday" do
    interval = DateInterval.parse("2014-01-03 - 2014-01-05, -friday")
    expected_interval = date_range("2014-01-04", "2014-01-05")

    assert_equal expected_interval, interval
  end

  test "includes saturday" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-04, none, +saturday")
    expected_interval = [to_date("2014-01-04")]

    assert_equal expected_interval, interval
  end

  test "excludes saturday" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-04, -saturday")
    expected_interval = date_range("2014-01-01", "2014-01-03")

    assert_equal expected_interval, interval
  end

  test "returns unique dates" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-02, +2014-01-02")
    expected_interval = date_range("2014-01-01", "2014-01-02")

    assert_equal expected_interval, interval
  end

  test "returns sorted dates" do
    interval = DateInterval.parse("2014-01-01 - 2014-01-02, +2013-12-31")
    expected_interval = date_range("2013-12-31", "2014-01-02")

    assert_equal expected_interval, interval
  end

  test "excludes holidays" do
    DateInterval::Filter::Holidays.add Date.parse("2014-01-01")

    interval = DateInterval.parse("2014-01-01 - 2014-01-02, -holidays")
    expected_interval = [to_date("2014-01-02")]

    assert_equal expected_interval, interval
  end

  test "includes holidays" do
    DateInterval::Filter::Holidays.add Date.parse("2014-01-01")

    interval = DateInterval.parse("2014-01-01 - 2014-01-02, none, +holidays")
    expected_interval = [to_date("2014-01-01")]

    assert_equal expected_interval, interval
  end

  test "detects expression as valid" do
    assert DateInterval.valid?("2014-01-01 - 2014-01-02")
  end

  test "detects expression as invalid" do
    refute DateInterval.valid?("invalid")
  end
end
