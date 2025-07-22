# frozen_string_literal: true

require_relative 'base'

module InterestStrategy
  class CompoundInterest < Base
    attr_reader :frequency

    PAYMENT_FREQUENCY_PERIODS = {
      'monthly' => 12,
      'quarterly' => 4,
      'annually' => 1
    }.freeze

    def initialize(frequency)
      super

      @frequency = frequency
    end

    def calculate(principal, interest_rate, term_years)
      periods_per_year = PAYMENT_FREQUENCY_PERIODS[frequency]
      rate_per_period = (interest_rate / 100.0) / periods_per_year
      total_periods = periods_per_year * term_years

      principal * ((1 + rate_per_period)**total_periods)
    end
  end
end
