# frozen_string_literal: true

module InterestStrategy
  class Base
    def calculate(principal, interest_rate, term_years)
      raise NotImplementedError
    end
  end
end