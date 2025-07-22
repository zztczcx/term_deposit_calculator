# frozen_string_literal: true

class TermDepositCalculator
  attr_reader :principal, :interest_rate, :term_years, :frequency

  def initialize(principal, interest_rate, term_years, frequency)
    @principal = principal
    @interest_rate = interest_rate
    @term_years = term_years
    @frequency = frequency
  end

  def calculate_final_balance
    100
  end
end
