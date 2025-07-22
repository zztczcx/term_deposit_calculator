# frozen_string_literal: true

class TermDepositCalculator
  PAYMENT_FREQUENCY_PERIODS = {
    'monthly' => 12,
    'quarterly' => 4,
    'annually' => 1,
    'at_maturity' => 1
  }.freeze

  attr_reader :principal, :interest_rate, :term_years, :frequency

  def initialize(principal, interest_rate, term_years, frequency)
    @principal = principal
    @interest_rate = interest_rate
    @term_years = term_years
    @frequency = frequency
  end

  def calculate_final_balance
    balance =
      if frequency == 'at_maturity'
        # Simple interest for payment at maturity
        principal * (1 + ((interest_rate / 100.0) * term_years))
      else
        # Compound interest for regular payments
        periods_per_year = PAYMENT_FREQUENCY_PERIODS[frequency]
        rate_per_period = (interest_rate / 100.0) / periods_per_year
        total_periods = periods_per_year * term_years

        principal * ((1 + rate_per_period)**total_periods)
      end

    balance.round(2)
  end
end
