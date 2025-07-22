# frozen_string_literal: true

require 'dry/cli'
require 'dry/validation'
require_relative 'term_deposit_calculator'

module CLI
  module Commands
    extend Dry::CLI::Registry

    class Calculate < Dry::CLI::Command
      desc 'Calculate term deposit returns with different payment frequencies'

      option :principal,
             type: :float, aliases: ['p'],
             desc: 'Start deposit amount (e.g., 10000)'
      option :rate,
             type: :float, aliases: ['r'],
             desc: 'Annual interest rate as percentage (e.g., 1.10)'
      option :term,
             type: :float, aliases: ['t'],
             desc: 'Investment term in years (e.g., 3)'
      option :frequency,
             type: :string, aliases: ['f'],
             desc: 'Payment frequency: monthly, quarterly, annually, at_maturity'

      example [
        '--principal 10000 --rate 1.10 --term 3 --frequency at_maturity      # Simple interest',
        '--principal 5000 --rate 2.5 --term 2 --frequency quarterly          # Compound quarterly',
        '-p 15000 -r 3.25 -t 1.5 -f monthly                                  # Compound monthly (short flags)'
      ]

      def call(**options)
        validated_inputs = validate_inputs(**options)
        calculator = TermDepositCalculator.new(
          validated_inputs[:principal],
          validated_inputs[:rate],
          validated_inputs[:term],
          validated_inputs[:frequency]
        )
        final_balance = calculator.calculate_final_balance

        display_results(final_balance.round(2))
      rescue ArgumentError => e
        puts "Argument Error: #{e.message}"
        puts "Run 'term_deposit_calc.rb calculate --help' for usage information."
        exit 1
      end

      private

      def validate_inputs(**options)
        contract = CalculateContract.new
        validation = contract.call(options)
        return validation.values unless validation.failure?

        validation.errors.each do |error|
          puts "Error: #{error.path.join('.')} #{error.text}"
        end
        puts "Run 'term_deposit_calc.rb calculate --help' for usage information."
        exit 1
      end

      def display_results(final_balance)
        puts "The Final balance is: $#{final_balance}."
      end
    end

    class CalculateContract < Dry::Validation::Contract
      FREQUENCIES = %w[
        monthly
        quarterly
        annually
        at_maturity
      ].freeze

      params do
        required(:principal).filled(:float)
        required(:rate).filled(:float)
        required(:term).filled(:float)
        required(:frequency).filled(:string)
      end

      rule(:principal) do
        key.failure('must be a positive number') if value <= 0
      end

      rule(:rate) do
        key.failure('must be a non-negative number') if value.negative?
      end

      rule(:term) do
        key.failure('must be a positive number') if value <= 0
      end

      rule(:frequency) do
        key.failure("must be one of: #{FREQUENCIES.join(', ')}") unless FREQUENCIES.include?(value.downcase)
      end
    end

    register 'calculate', Calculate, aliases: %w[calc c]
  end
end
