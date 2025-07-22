# frozen_string_literal: true

require 'spec_helper'

RSpec.describe TermDepositCalculator do
  describe '#initialize' do
    it 'creates a valid calculator with proper inputs' do
      calculator = TermDepositCalculator.new(10_000, 1.10, 3, 'annually')

      expect(calculator.principal).to eq(10_000.0)
      expect(calculator.interest_rate).to eq(1.10)
      expect(calculator.term_years).to eq(3.0)
      expect(calculator.frequency).to eq('annually')
    end
  end

  describe '#calculate_final_balance' do
    context 'with payment at maturity' do
      it 'calculates correctly' do
        calculator = TermDepositCalculator.new(10_000, 1.10, 3, 'at_maturity')
        final_balance = calculator.calculate_final_balance

        expect(final_balance).to eq(10_330)
      end

      it 'calculates correctly for different inputs' do
        calculator = TermDepositCalculator.new(5000, 2.5, 2, 'at_maturity')
        final_balance = calculator.calculate_final_balance

        expect(final_balance).to eq(5250)
      end
    end

    context 'with compound interest' do
      it 'calculates correctly for annual compounding' do
        calculator = TermDepositCalculator.new(10_000, 5.0, 2, 'annually')
        final_balance = calculator.calculate_final_balance

        expect(final_balance).to eq(11_025)
      end

      it 'calculates correctly for quarterly compounding' do
        calculator = TermDepositCalculator.new(1000, 4.0, 1, 'quarterly')
        final_balance = calculator.calculate_final_balance

        expect(final_balance).to eq(1040.6)
      end

      it 'calculates correctly for monthly compounding' do
        calculator = TermDepositCalculator.new(2000, 6.0, 1, 'monthly')
        final_balance = calculator.calculate_final_balance

        expect(final_balance).to eq(2123.36)
      end
    end

    context 'edge cases' do
      it 'handles zero interest rate' do
        calculator = TermDepositCalculator.new(10_000, 0, 3, 'annually')
        final_balance = calculator.calculate_final_balance

        expect(final_balance).to eq(10_000)
      end

      it 'handles fractional years' do
        calculator = TermDepositCalculator.new(10_000, 5.0, 0.5, 'annually')
        final_balance = calculator.calculate_final_balance

        expect(final_balance).to eq(10_246.95)
      end
    end
  end
end
