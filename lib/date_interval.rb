# frozen_string_literal: true

require "date"
require "parslet"
require "forwardable"

require "date_interval/date"
require "date_interval/filter"
require "date_interval/filter/operator"
require "date_interval/filter/date"
require "date_interval/filter/none"
require "date_interval/filter/weekday"
require "date_interval/filter/weekdays"
require "date_interval/filter/holidays"
require "date_interval/filter/weekend"
require "date_interval/parser"
require "date_interval/transformer"
require "date_interval/version"

module DateInterval
  InvalidRuleError = Class.new(StandardError)

  def self.parse(expression)
    tree = parser.parse(expression)
    ast = transformer.apply(tree)

    Filter.filter(
      ast[:intervals].flatten.uniq,
      ast[:filters].is_a?(Array) ? ast[:filters] : []
    )
  end

  def self.valid?(expression)
    parser.parse(expression)
    true
  rescue Parslet::ParseFailed
    false
  end

  def self.parser
    Parser.new
  end

  def self.transformer
    Transformer.new
  end
end
