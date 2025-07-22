# frozen_string_literal: true

require_relative 'interest_strategy/base'
require_relative 'interest_strategy/simple_interest'
require_relative 'interest_strategy/compound_interest'

class TermDepositCalculator
  attr_reader :principal, :interest_rate, :term_years, :frequency, :strategy

  def initialize(principal, interest_rate, term_years, frequency)
    @principal = principal
    @interest_rate = interest_rate
    @term_years = term_years
    @frequency = frequency

    @strategy = if frequency == 'at_maturity'
                  InterestStrategy::SimpleInterest.new
                else
                  InterestStrategy::CompoundInterest.new(frequency)
                end
  end

  def calculate_final_balance
    balance = strategy.calculate(principal, interest_rate, term_years)
    balance.round(2)
  end
end
