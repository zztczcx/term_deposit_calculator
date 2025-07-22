# frozen_string_literal: true

require_relative 'base'

module InterestStrategy
  class SimpleInterest < Base
    def calculate(principal, interest_rate, term_years)
      principal * (1 + ((interest_rate / 100.0) * term_years))
    end
  end
end
